require "rspec/feature_helpers/version"

module RSpec
  module FeatureHelpers
    extend ActiveSupport::Concern

    included do
      let(:user) { create(:user) }
    end
  end
end

RSpec.configure do |config|

  config.include Warden::Test::Helpers, type: :feature if defined?(Warden)
  config.include RSpec::FeatureHelpers, type: :feature

  config.before :each, type: :feature, logged_in: true do
    # Always log in a user prior to running scenarios with 'logged_in' metadata.
    # You can customize the user instances on a per scenario context by using
    # RSpec's memoization. For example:
    # 
    # let(:user) { create(:admin_user) }
    login_as user
  end

  if defined?(Capybara)
    config.before :each, type: :feature do
      # Always use a JS capable driver when running feature tests
      Capybara.current_driver = Capybara.javascript_driver
    end

    config.after :each, type: :feature do
      # Cleanup after each feature!
      Capybara.reset_sessions!
      Capybara.use_default_driver
    end
  end
end
