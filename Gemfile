# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.1"

gem "bcrypt", "~> 3.1.7"
gem "chronic"
gem "date_validator"
gem "devise"
gem "devise_token_auth"
gem "email_validator"
gem "factory_bot_rails"
gem "faker"
gem "friendly_id"
gem "gretel"
gem "inline_svg"
gem "jbuilder", "~> 2.5"
gem "json-schema"
gem "mini_magick"
gem "paranoia"
gem "pg"
gem "puma", "~> 3.11"
gem "pundit"
gem "rails", "~> 5.2.1"
gem "rails_event_store", "~> 0.29.0"
gem "rolify"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "validates_timeliness", "~> 5.0.0.alpha2"

group :development, :test do
  gem "awesome_print"
  gem "byebug"
  gem "dotenv-rails"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "pundit-matchers"
  gem "rubocop"
  gem "rubocop-rspec"
  gem "vcr"
  gem "webmock"
end

group :development do
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15", "< 4.0"
  gem "capybara-screenshot"
  gem "chromedriver-helper"
  gem "coveralls", require: false
  gem "database_cleaner"
  gem "rspec-rails"
  gem "rspec_junit_formatter"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "simplecov", require: false
end
