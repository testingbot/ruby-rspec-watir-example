require_relative "spec_helper"

describe "Google Search" do
  it "can find search results" do
    @browser.goto("https://www.google.com/ncr")
    @browser.text_field({name: "q"}).set 'TestingBot'
	@browser.form({name: "f"}).submit
	sleep 5
	expect(@browser.title).to eql("TestingBot - Google Search")
  end
end
