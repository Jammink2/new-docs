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
disable :protection

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
  @env = get_environment(request)
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

get '/categories/:category' do
  @env = get_environment(request)
  if params[:category] == 'success-stories'
    redirect "http://www.treasuredata.com/en/learn/customer-stories.php"
  else
    cache_long
    render_category params[:category]
  end
end

get '/articles/:article' do
  @env = get_environment(request)
  m = /^success-at-(.*)/.match(params[:article])
  if m
    redirect "http://www.treasuredata.com/#{m[1]}.php"
  else
    m = /^legacy-releasenotes$/.match(params[:article])
    if m
      render_template params[:article], :releasenotes_redirect, @env
    else
      cache_long
      render_template params[:article], :article, @env
    end
  end
end

get '/feedback' do
  erb :feedback, :layout => false
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

  def render_template(article, template, env)
    @filepath = article_file(article)
    unless $IO_CACHE.has_key? @filepath
      $IO_CACHE[@filepath] = File.read(@filepath)
    end

    @article = Article.load(article, $IO_CACHE[@filepath], env)
    @title   = @article.title
    @desc    = @article.desc
    @content = @article.content
    @intro   = @article.intro
    @toc     = @article.toc
    @body    = @article.body

    erb template
  rescue Errno::ENOENT
    p $!
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
    response['Cache-Control'] = "public, max-age=#{60 * 60 * 6}" unless settings.development?
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

  def get_environment(request)
    env = (request.host =~ /ybi-docs\.idcfcloud\.com/) ? :idcf : :aws
    {
      :aws => {
        :name => 'Treasure Data',
        :region => :aws,
        :prefix => '',
        :about => 'http://www.treasuredata.com/about.php',
        :logo => '/images/treasure-logo-white.png',
        :favicon => '/favicon.ico',
        :swiftype_key => '7GEG12Fu5wjuAjfExr5K',
        :olark => true,
        :url_top => 'http://www.treasuredata.com/',
        :url_doc => 'http://docs.treasuredata.com/',
        :url_product => 'http://www.treasuredata.com/technology.php',
        :url_developers => 'http://www.treasuredata.com/developers.php',
        :url_solutions => 'http://www.treasuredata.com/solutions.php',
        :url_resources => 'http://www.treasuredata.com/resources.php',
        :url_about => 'http://www.treasuredata.com/about.php',
        :url_contact => 'http://www.treasuredata.com/contact.php',
        :url_login => 'https://console.treasuredata.com/users/sign_in',
        :url_signup => 'https://console.treasuredata.com/users/sign_up',
        :url_users => 'https://console.treasuredata.com/users',
        :url_profile => 'https://console.treasuredata.com/users/current',
        :url_databases => 'https://console.treasuredata.com/databases',
        :url_import => 'https://console.treasuredata.com/import',
        :url_job => 'https://console.treasuredata.com/jobs',
        :url_console => 'https://console.treasuredata.com',
        :console_string => 'console.treasuredata.com',
        :api_endpoint => 'api.treasuredata.com',
        :sdk_endpoint => 'in.treasuredata.com',
        :pggw_endpoint => 'pggw.treasuredata.com',
        :mail_support => 'support@treasure-data.com'
      },
      :idcf => {
        :name => 'Yahoo! Big Data Insight',
        :region => :idcf,
        :prefix => 'ybi_',
        :about => 'http://www.idcf.jp/company/',
        :logo => '/images/ybi-logo.png',
        :favicon => '/favicon_idcf.png',
        :swiftype_key => 'o3ng6KvhmZNK2h4we63e',
        :olark => false,
        :url_top => 'http://www.idcf.jp/bigdata/',
        :url_doc => 'http://ybi-docs.idcfcloud.com/',
        :url_product => 'http://www.idcf.jp/bigdata/',
        :url_developers => 'http://www.idcf.jp/bigdata/use.html',
        :url_solutions => 'http://www.idcf.jp/bigdata/',
        :url_resources => 'http://www.idcf.jp/bigdata/use.html',
        :url_about => 'http://www.idcf.jp/company/',
        :url_contact => 'https://www.idcf.jp/inquiry/?cid=ybidoc01',
        :url_login => 'https://console-ybi.idcfcloud.com/users/sign_in?cid=ybidoc',
        :url_signup => 'https://console-ybi.idcfcloud.com/users/sign_up?cid=ybidoc',
        :url_users => 'https://console-ybi.idcfcloud.com/users',
        :url_profile => 'https://console-ybi.idcfcloud.com/users/current',
        :url_databases => 'https://console-ybi.idcfcloud.com/databases',
        :url_import => 'https://console-ybi.idcfcloud.com/import',
        :url_job => 'https://console-ybi.idcfcloud.com/jobs',
        :url_console => 'https://console-ybi.idcfcloud.com',
        :console_string => 'console-ybi.idcfcloud.com',
        :api_endpoint => 'ybi.jp-east.idcfcloud.com',
        :sdk_endpoint => 'mobile-ybi.jp-east.idcfcloud.com',
        :pggw_endpoint => 'pggw-ybi.jp-east.idcfcloud.com',
        :mail_support => 'ybi-support@idc.jp'
      }
    }[env]
  end
end

