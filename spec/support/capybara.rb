RSpec.configure do |config|
  config.before :each, js: true do
    page.driver.block_unknown_urls
  end
end

Capybara.javascript_driver = :webkit
