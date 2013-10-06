require 'rubygems'
require 'sinatra'
require 'sinatra/assetpack'
require 'haml'
require 'sass'
require 'coderay'
require 'indextank'
require 'rack/codehighlighter'

$LOAD_PATH << File.dirname(__FILE__) + '/lib'
require 'article.rb'
require 'term.rb'

# Airbrake
configure :production do
  require 'airbrake'
  Airbrake.configure do |config|
    config.api_key = `ENV['AIRBRAKE_API_KEY']`
  end
  use Airbrake::Rack
end

# NewRelic
configure :production do
  require 'newrelic_rpm'
end

# require 'rack/coderay'
# use Rack::Coderay, "//pre[@lang]>code"
use Rack::Codehighlighter, :coderay, :markdown => true, :element => "pre>code", :pattern => /\A:::(\w+)\s*(\n|&#x000A;)/i, :logging => false
configure :production do
  ENV['APP_ROOT'] ||= File.dirname(__FILE__)
end

set :app_file, __FILE__
set :static_cache_control, [:public, :max_age => 3600*24]

# In-Mem Cache
$IO_CACHE ||= {}
configure :production do
  if $IO_CACHE.empty?
    Dir.glob("#{settings.root}/docs/*.txt") { |path|
      $IO_CACHE[path] = File.read(path)
    }
  end
end

#
# NOT FOUND
#
not_found do
  erb :not_found
end

#
# Static Assets
# @see http://ricostacruz.com/sinatra-assetpack/
#
set :root, File.dirname(__FILE__)
Sinatra.register Sinatra::AssetPack
assets {
  serve '/js',  from: 'app/js'  # Optional
  serve '/css', from: 'app/css' # Optional
  js :app, '/js/app.js', [
    '/js/*.js'
  ]
  css :application, '/css/application.css', [
    '/css/*.css'
  ]
  js_compression  :jsmin
  css_compression :simple
  prebuild true # only on production
  expires 24*3600*7, :public
}

#
# OLD REDIRECTS
#
get '/getting_started.html' do redirect '/articles/quickstart' end
get '/getting_started_with_apache_logs.html' do redirect '/articles/quickstart' end
get '/getting_started_with_ruby_on_rails.html' do redirect '/articles/rails' end
get '/continuous_data_import_with_td-agent.html' do redirect '/articles/td-agent' end
get '/td-agent_ha.html' do redirect '/articles/td-agent-high-availability' end
get '/database_table_management.html' do redirect '/articles/database-and-table' end
get '/schema_management.html' do redirect '/articles/schema' end
get '/job_management.html' do redirect '/articles/job' end
get '/query_language.html' do redirect '/articles/hive' end
get '/articles/apache' do redirect '/articles/analyzing-apache-logs' end
get '/articles/tweet-stream-analysis-hurricane-sandy' do redirect '/articles/analyzing-twitter-data' end

#
# PATHS
#
get '/' do
  # cache_long
  # haml :index
  # @title   = 'Documentation | Treasure Data'
  # @desc    = 'Documentation of Treasure Data, Hadoop-based Cloud Data Warehouse.'
  # @toc     = []
  # erb :index
  redirect '/articles/quickstart'
end

get '/robots.txt' do
  content_type 'text/plain'
  "User-agent: *\nSitemap: /sitemap.xml\n"
end

get '/sitemap.xml' do
  @articles = []
  sections.each { |_, _, categories|
    categories.each { |_, _, articles|
      articles.each { |name, _, _|
        @articles << name
      }
    }
  }
  content_type 'text/xml'
  erb :sitemap, :layout => false
end

get '/search' do
  page = params[:page].to_i
  search, prev_page, next_page = search_for(params[:q], page)
  erb :search, :locals => {:search => search, :query => params[:q], :prev_page => prev_page, :next_page => next_page}
end

get '/categories/:category' do
  if params[:category] == 'success-stories'
    redirect "http://www.treasure-data.com/case-studies"
  else
    cache_long
    render_category params[:category]
  end
end

get '/articles/:article' do
  m = /^success-at-(.*)/.match(params[:article])
  if m
    redirect "http://www.treasure-data.com/success-stories/#{m[1]}"
  else
    cache_long
    render_article params[:article], params[:congrats]
  end
end

require 'toc'
$TOC = TOC.new("en")


helpers do
  def render_category(category)
    @articles = []
    @desc = ''
    sections.each { |_, _, categories|
      categories.each { |name, title, articles|
        if name == category
          @title = title
          @articles = articles
          @desc = title
          break
        end
      }
    }
    if @articles.length == 1
      article_name = @articles.first.first
      redirect "/articles/#{article_name}"
    elsif !@articles.empty?
      erb :category
    else
      status 404
    end
  rescue Errno::ENOENT
    status 404
  end

  def render_article(article, congrats)
    @filepath = article_file(article)
    unless $IO_CACHE.has_key? @filepath
      $IO_CACHE[@filepath] = File.read(@filepath)
    end
    @article = Article.load(article, $IO_CACHE[@filepath])

    @title   = @article.title
    @desc    = @article.desc
    @content = @article.content
    @intro   = @article.intro
    @toc     = @article.toc
    @body    = @article.body
    @congrats = congrats ? true : false

    erb :article
  rescue Errno::ENOENT
    status 404
  end

  def article_file(article)
    if article.include?('/')
      article
    else
      "#{settings.root}/docs/#{article}.txt"
    end
  end

  def cache_long
    response['Cache-Control'] = "public, max-age=#{60 * 60 * 6}" unless development?
  end

  def slugify(title)
    title.downcase.gsub(/[^a-z0-9 -]/, '').gsub(/ /, '-')
  end

  def find_category(article)
    return nil if article.nil?
    sections.each { |_, _, categories|
      categories.each { |category_name, _, articles|
        articles.each { |article_name, _, _|
          return category_name if article_name == article
        }
      }
    }
    nil
  end

  def find_keywords(article, category)
    default = ['Treasure Data', 'hadoop', 'hive', 'cloud data warehouse']
    sections.each { |_, _, categories|
      categories.each { |category_name, _, articles|
        return default + [category_name] if category_name == category
        articles.each { |article_name, _, keywords|
          return default + keywords if article_name == article
        }
      }
    }
    default
  end

  def sections
    $TOC.sections
  end

  def next_section(current_slug, root=sections)
    nil
  end

  def search_for(query, page = 0)
    client = IndexTank::Client.new(ENV['SEARCHIFY_API_URL'])
    index = client.indexes('td-docs')
    search = index.search(query, :start => page * 10, :len => 10, :fetch => 'title', :snippet => 'text')
    next_page =
        if search['matches'] > (page + 1) * 10
          page + 1
        end
    prev_page =
        if page > 0
          page - 1
        end
    [search, prev_page, next_page]
  end

  alias_method :h, :escape_html
end

