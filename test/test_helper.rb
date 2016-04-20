ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails/capybara'
require 'capybara/webkit'
require 'database_cleaner'

Capybara.javascript_driver = :webkit

Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }
# include helpers
Dir[Rails.root.join("test/helpers/**/*.rb")].each { |f| require f }

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  require 'minitest/reporters'
  Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

  Capybara.javascript_driver = :webkit
end
