require 'rspec'
require 'spec_helper.rb'
require $TEST_BASE+'/../pages/EverfiPageCommon.rb'
require $TEST_BASE+'/../pages/EverfiCommonTabs.rb'
require $TEST_BASE+'/../pages/EverfiHomePage.rb'

describe "verify tabs in Everfi Home Page",:hometabs do
  before(:all) do
    @common = EverfiPageCommon.new($session)
    @tabs = EverfiCommonTabs.new($session)
    @home = EverfiHomePage.new($session)
    @common.loginProcess()
  end

  it "user navigates to Home page" do
    @tabs.clickHomeTab()
    expect($session).to have_xpath(@home.homePageXpath())
  end

  it "user verifies Upcoming Sessions Tab" do
    title = @home.clickAndGetUpcomingSessionsText()
    expect(title).to include("Upcoming Sessions")

  end

  it "user verifies Past Sessions Tab" do
    title = @home.clickAndGetPastSessionsText()
    expect(title).to include("Past Sessions")
  end

  after(:all) do
    @common.logoutProcess()
    expect($session).to have_content("Administrator Log In")
  end
end