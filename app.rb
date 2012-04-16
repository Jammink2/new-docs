require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'coderay'
require 'rack/codehighlighter'

$LOAD_PATH << File.dirname(__FILE__) + '/lib'
require 'article.rb'
require 'term.rb'

# Basic auth: @see .env file
use Rack::Auth::Basic do |username, password|
  username == 'member' && password == 'password'
end

# require 'rack/coderay'
# use Rack::Coderay, "//pre[@lang]>code"
use Rack::Codehighlighter, :coderay, :markdown => true, :element => "pre>code", :pattern => /\A:::(\w+)\s*(\n|&#x000A;)/i, :logging => false
configure :production do
  ENV['APP_ROOT'] ||= File.dirname(__FILE__)
end

set :app_file, __FILE__

#
# NOT FOUND
#
not_found do
  erb :not_found
end

# 
# PATHS
#
get '/' do
  # cache_long
  # haml :index
  redirect '/articles/quickstart'
end

get '/categories/:category' do
  cache_long
  render_category params[:category]
end

get '/articles/:article' do
  cache_long
  render_article params[:article]
end

get '/css/docs.css' do
  cache_long
  content_type 'text/css'
  erb :css, :layout => false
end

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

helpers do
  def render_category(category)
    @articles = []
    sections.each { |_, _, categories|
      categories.each { |name, title, articles|
        if name == category
          @title = title
          @articles = articles
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

  def render_article(article)
    source = File.read(article_file(article))
    @article = Article.load(article, source)
    
    @title   = @article.title
    @content = @article.content
    @intro   = @article.intro
    @toc     = @article.toc
    @body    = @article.body
    
    erb :article
  rescue Errno::ENOENT
    status 404
  end

  def article_file(article)
    if article.include?('/')
      article
    else
      "#{options.root}/docs/#{article}.txt"
    end
  end

  def cache_long
    # response['Cache-Control'] = "public, max-age=#{60 * 60}" unless development?
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

  def sections
    TOC.sections
  end

  def next_section(current_slug, root=sections)
    nil
  end

  alias_method :h, :escape_html
end

module TOC
  extend self

  def sections
    @sections ||= []
  end

  # define a section
  def section(name, title)
    sections << [name, title, []]
    yield if block_given?
  end

  # define a category
  def category(name, title)
    sections.last.last << [name, title, []]
    yield if block_given?
  end

  # define a article
  def article(name, title)
    sections.last.last.last.last << [name, title, []]
  end

  file = File.dirname(__FILE__) + '/lib/toc.rb'
  eval File.read(file), binding, file
end
