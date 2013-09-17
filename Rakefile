require 'rubygems'
require 'bundler'
Bundler.setup

$LOAD_PATH << File.dirname(__FILE__) + '/lib'
require 'article'
require 'indextank'

desc 'start a development server'
task :server do
  if which('shotgun')
    exec 'shotgun -O app.rb'
  else
    warn 'warn: shotgun not installed; reloading is disabled.'
      exec 'ruby -rubygems app.rb -p 9393'
  end
end
def which(command)
  ENV['PATH'].
    split(':').
    map  { |p| "#{p}/#{command}" }.
    find { |p| File.executable?(p) }
end
task :start => :server

desc 'index documentation'
task :index do
  puts "indexing now:"
  client = IndexTank::Client.new(ENV['SEARCHIFY_API_URL'])
  index = client.indexes('td-docs')
  index.add unless index.exists?

  docs = FileList['docs/*.txt']
  docs.each do |doc|
    name = File.basename(doc, '.txt')
    puts "...indexing #{name}"
    source = File.read(doc)
    topic = Article.load(name, source)
    topic.text_only
    result = indextank_document = index.document(name).add(:title => topic.title, :text => topic.body)
    puts "=> #{result}"
  end
  puts "finished indexing"
end

def parse_docs_path(file)
  lang, name = file['docs/'.size..-1].split('/', 2)
  if name.nil?
    name = lang
    lang = 'en'
  end

  return lang, name
end

desc 'list outdated documents'
task :outdated do
  base = {}
  `git ls-files docs/*.txt`.split("\n").each { |file|
    lang, name = parse_docs_path(file)
    path = Pathname.new(file).realpath.to_s
    base[name] = Time.at((`git log --pretty=%ct --max-count=1 #{path}`.strip).to_i).utc
  }

  longest = 0;
  outdated_files = []
  `git ls-files docs/*/*.txt`.split("\n").each { |file|
    _, name = parse_docs_path(file)
    if base_time = base[name]
      path = Pathname.new(file).realpath.to_s
      diff = base_time - Time.at((`git log --pretty=%ct --max-count=1 #{path}`.strip).to_i).utc
      if diff > 0.0
        days, hours = diff.divmod(24 * 60 * 60)
        outdated = "#{hours.divmod(60 * 60).first.to_i} hours"
        outdated = "#{days.to_i} days, #{outdated}" if days > 0
        #puts "#{file}:  #{outdated}"
        outdated_files << [file, outdated]
        longest = file.length if file.length > longest
      end
    end
  }

  outdated_files.each { |file, outdated|
    puts "#{file}#{' ' * (longest - file.length + 1)}: #{outdated}"
  }
end
