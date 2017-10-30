source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem "omniauth"
gem "omniauth-github"

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'aws-sdk', '< 3.0'
gem 'paperclip'
gem 'figaro'
gem 'will_paginate', '~> 3.1.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'dotenv-rails'
  gem 'aws-sdk', '< 3.0'
  gem 'paperclip'
  gem 'figaro'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'jquery-turbolinks'
gem 'foundation-rails', '6.4.1.2'


group :development do
  gem 'better_errors'
  gem 'pry-rails'
  gem 'binding_of_caller'
  gem 'rails-erd', require: false
end

group :test do
  gem 'minitest-rails'
  gem 'minitest-reporters'
  gem 'simplecov', :require => false
end
