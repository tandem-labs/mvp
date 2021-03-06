# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)

if Rails.env.production?
  # Prevent database truncation if the environment is production
  abort("The Rails environment is running in production mode!")
end

require "rspec/rails"
# Add additional requires below this line. Rails is not loaded until this point!
require "capybara/rspec"
require "database_cleaner"
require "shoulda/matchers"
require "vcr"

# this must be after `capybara/rspec` so moving it down here so it is not ABC'd
require "capybara-screenshot/rspec"

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.configure_rspec_metadata!
  config.default_cassette_options[:match_requests_on] = %i[method path]
  config.hook_into :webmock
end

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join("spec", "support", "**", "*.rb")].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

# rubocop:disable Metrics/BlockLength
RSpec.configure do |config|
  config.include DeviseRequestSpecHelpers, type: :request
  config.include FactoryBot::Syntax::Methods

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true

  # Rails.application.eager_load!

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.render_views = true

  # Configure DatabaseCleaner + RSpec + Capybara
  # https://github.com/DatabaseCleaner/database_cleaner#rspec-with-capybara-example
  config.use_transactional_fixtures = false

  [ActiveRecord::Base].each do |model|
    # ActiveRecord::Base.establish_connection db

    config.before(:suite) do
      if config.use_transactional_fixtures?
        raise(<<-MSG)
          Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
          (or set it to false) to prevent uncommitted transactions being used in
          JavaScript-dependent specs.

          During testing, the app-under-test that the browser driver connects to
          uses a different database connection to the database connection used by
          the spec. The app's database connection would not be able to access
          uncommitted transaction data setup over the spec's database connection.
        MSG
      end

      DatabaseCleaner[:active_record, { model: model }].clean_with(:truncation)
    end

    config.before(:each, type: :feature) do
      # :rack_test driver's Rack app under test shares database connection
      # with the specs, so continue to use transaction strategy for speed.
      driver_shares_db_connection_with_specs =
        Capybara.current_driver == :rack_test

      unless driver_shares_db_connection_with_specs
        # Driver is probably for an external browser with an app
        # under test that does *not* share a database connection with the
        # specs, so use truncation strategy.

        DatabaseCleaner[:active_record, { model: model }].strategy = :truncation
      end
    end

    config.before do
      DatabaseCleaner[:active_record, { model: model }].strategy = :transaction
    end

    config.before do
      DatabaseCleaner[:active_record, { model: model }].start
    end

    config.append_after do
      DatabaseCleaner[:active_record, { model: model }].clean
    end
  end

  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

  Capybara::Screenshot.prune_strategy = { keep: 1 }
  Capybara.default_max_wait_time = 5
end
# rubocop:enable Metrics/BlockLength
