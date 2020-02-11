require 'capybara/rails'
require 'webdrivers/chromedriver'

Capybara.register_driver :chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    loggingPrefs: {
      browser: 'ALL'
    }
  )

  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('window-size=1600,1268')

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities,
    options: options
  )
end

Capybara.default_max_wait_time = 3
Capybara.javascript_driver = :chrome
Capybara.default_driver = :chrome
Capybara.server = :puma
Capybara.raise_server_errors = false
