require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'coderay'
require 'rack/codehighlighter'

$LOAD_PATH << File.dirname(__FILE__) + '/lib'
require 'article.rb'
require 'term.rb'

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
  cache_long
  haml :index
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
    response['Cache-Control'] = "public, max-age=#{60 * 60}" unless development?
  end

  def slugify(title)
    title.downcase.gsub(/[^a-z0-9 -]/, '').gsub(/ /, '-')
  end

  def sections
    TOC.sections
  end

  def next_section(current_slug, root=sections)
    return sections.first if current_slug.nil?
    root.each_with_index do |(slug, title, articles), i|
      if current_slug == slug and i < root.length-1
        return root[i+1]
      elsif articles.any?
        res = next_section(current_slug, articles)
        return res if res
      end
    end
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
