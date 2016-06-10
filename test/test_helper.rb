require 'coveralls'
Coveralls.wear!

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Load fixtures from the engine
  if ActiveSupport::TestCase.respond_to?(:fixture_path=)
    ActiveSupport::TestCase.fixture_path = File.expand_path('../fixtures', __FILE__)
    ActiveSupport::TestCase.fixtures :all
  end
end
