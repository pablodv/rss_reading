source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.13'
gem 'jquery-rails'

gem 'pg'

group :test do
  gem "cucumber-rails", require: false
  gem "capybara"
  gem "launchy"
  gem "shoulda-matchers"
  gem "database_cleaner"
  gem "simplecov", require: false
end

group :test, :development do
  gem "rspec-rails",        '2.10.1'
  gem "factory_girl_rails", '3.4.0'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem "twitter-bootstrap-rails"
end

gem "slim"
gem "slim-rails"

gem 'activeadmin'
gem "meta_search", '>= 1.1.0.pre'

gem "paperclip",   '~> 3.0'

gem "omniauth-google-oauth2"
gem "omniauth-twitter"

gem "feedzirra"

gem 'whenever', require: false
