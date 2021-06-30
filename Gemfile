source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bootsnap', '>= 1.4.4', require: false # Reduces boot times through caching
gem 'pg', '~> 1.1' # the database for Active Record
gem 'puma', '~> 5.0' # the app server
gem 'rails', '~> 6.1.0'
gem 'sass-rails', '>= 6' # SCSS for stylesheets

group :development, :test do
  gem 'pry-byebug' # neat debugger
  gem 'pry-rails' # causes rails console to open pry.
  gem 'pry-stack_explorer' # Walk the stack in a Pry session
end

group :development do
  gem 'listen', '~> 3.3' # istens to file modifications and notifies you about the changes
  gem 'rubocop', require: false # Ruby code linter
  gem 'rubocop-performance' # rubocop extension focused on code performance checks.
  gem 'rubocop-rails' # rubocop extension for Rails
  gem 'rubocop-rspec' # Code style checking for RSpec files
  gem 'spring' # speeds up development by keeping your application running in the background
end
