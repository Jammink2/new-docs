require 'rubygems'
require 'bundler'
Bundler.setup

$LOAD_PATH << File.dirname(__FILE__) + '/lib'
require 'article'

desc 'Start a development server'
task :server do
  if which('shotgun')
    exec 'shotgun -O app.rb'
  else
    warn 'warn: shotgun not installed; reloading is disabled.'
      exec 'ruby -rubygems app.rb -p 9393'
  end
end

task :start => :server

def which(command)
  ENV['PATH'].
    split(':').
    map  { |p| "#{p}/#{command}" }.
    find { |p| File.executable?(p) }
end
