# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

# Login user
include Warden::Test::Helpers

RSpec.configure do |config|
  config.include Warden::Test::Helpers
end

# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'

# Load site prism page objects
require File.expand_path('support/pages/base_page', __dir__)

# Load modules under the spec/support directory
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].sort.each { |file| require file }

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
