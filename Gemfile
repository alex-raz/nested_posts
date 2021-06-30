# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bootsnap', '>= 1.4.4', require: false # Reduces boot times through caching
gem 'pg', '~> 1.1' # the database for Active Record
gem 'puma', '~> 5.0' # the app server
gem 'rails', '~> 6.1.0'
gem 'sass-rails', '>= 6' # SCSS for stylesheets

group :development, :test do
  gem 'bullet' # helps to kill N+1 queries and unused eager loading
  gem 'factory_bot_rails' # ..is a fixtures replacement with a straightforward definition syntax
  gem 'faker' # Generates fake data.
  gem 'guard' # command line tool to easily handle events on file system modifications
  gem 'guard-rspec', require: false # launch specs when files are modified
  gem 'pry-byebug' # neat debugger
  gem 'pry-rails' # causes rails console to open pry.
  gem 'pry-stack_explorer' # Walk the stack in a Pry session
  gem 'rb-fsevent', require: false # FSEvents API with signals handled (without RubyCocoa)
  gem 'rspec-rails' # testing framework
  gem 'terminal-notifier-guard', require: false # Mac OS X User Notifications for Guard
end

group :development do
  gem 'annotate' # Annotate Rails classes with schema and routes info
  gem 'listen', '~> 3.3' # istens to file modifications and notifies you about the changes
  gem 'rubocop', require: false # Ruby code linter
  gem 'rubocop-performance' # rubocop extension focused on code performance checks.
  gem 'rubocop-rails' # rubocop extension for Rails
  gem 'rubocop-rspec' # Code style checking for RSpec files
  gem 'spring' # speeds up development by keeping your application running in the background
  gem 'spring-commands-rspec' # implements the rspec command for Spring
  gem 'spring-watcher-listen' # makes Spring watch the filesystem for changes using Listen
end

group :test do
  gem 'shoulda-matchers' # Collection of testing matchers extracted from Shoulda
end
