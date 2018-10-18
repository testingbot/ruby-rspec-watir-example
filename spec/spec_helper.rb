require "rspec/expectations"
require "watir"
require "rspec"
require 'testingbot'

RSpec.configure do | config |
  config.before(:each) do | x |
    url = "https://#{ENV['TB_KEY']}:#{ENV['TB_SECRET']}@hub.testingbot.com/wd/hub".strip
    @browser = Watir::Browser.new(:remote, browser: ENV['browserName'], name: x.full_description, platform: ENV['platform'], version: ENV['version'], url: url)
  end

  config.after(:each) do | example |
    sessionid = @browser.driver.send(:bridge).session_id
    @browser.quit

    api = TestingBot::Api.new(ENV['TB_KEY'], ENV['TB_SECRET'])
    if example.exception
      api.update_test(sessionid, { :success => false })
    else
      api.update_test(sessionid, { :success => true })
    end
  end
end
