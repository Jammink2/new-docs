source 'https://rubygems.org'

# https://devcenter.heroku.com/articles/ruby-versions
ruby '2.1.2'

gem 'sinatra', '1.4.5'
gem 'sinatra-assetpack', '0.3.3', :require => 'sinatra/assetpack'
gem 'rdiscount', '1.6.8'
gem 'rest-client', '1.2.0'
gem 'haml', '2.2.17'
gem 'coderay'
gem 'rack-codehighlighter'
gem 'sanitize'
gem 'jemalloc', '~> 0.1.7'
gem 'rack-canonical-host', '~> 0.0.8'
gem 'td', '=0.11.2'

# Webserver
gem 'unicorn', '~> 4.8.3'
gem 'unicorn-worker-killer', '~> 0.2.0'

# Addons
gem "newrelic_rpm", "~> 3.5.7.59"
gem 'indextank', '~> 1.0.12'
gem 'airbrake', '~> 3.1.5'

# Dev
group :development do
  gem 'rake'
  gem 'shotgun', '~> 0.9'
end

# Production
group :production do
  gem 'rack-cache', '~> 1.2'
  gem 'dalli', '~> 2.1.0'
end
