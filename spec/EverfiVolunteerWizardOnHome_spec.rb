require 'rspec'
require 'spec_helper.rb'
require $TEST_BASE+'/../pages/EverfiPageCommon.rb'
require $TEST_BASE+'/../pages/EverfiCommonTabs.rb'
require $TEST_BASE+'/../pages/EverfiHomePage.rb'
require $TEST_BASE+'/../pages/VolunteerLoginPage.rb'

describe "verify volunteers portal on home page",:volunteersHome do

  before(:all) do
    @common = EverfiPageCommon.new($session)
    @tabs = EverfiCommonTabs.new($session)
    @home = EverfiHomePage.new($session)
    @volLogin = VolunteerLoginPage.new($session)
    @common.loginProcess()
  end

  it "user navigates to Home page" do
    @tabs.clickHomeTab()
    expect($session).to have_xpath(@home.homePageXpath())
  end

  it "user clicks on Volunteer Portal" do
    @home.clickVolunteerPortalLink()
  end

  it "Volunteer portal login page should be displayed" do
    pageTitle = @volLogin.getPageTitle()
    expect("FiLive | Volunteer Log in").to eq(pageTitle)
    expect($session).to have_xpath(@volLogin.emailFieldXpath())
  end

  it "user navigates back to Home page" do
    @common.windowBack()
  end

  it "user clicks on Volunteer Portal session wizard" do
    @home.clickVolunteerSessionWizardLink()
  end

  it "Volunteer portal login page should be displayed" do
    pageTitle = @volLogin.getPageTitle()
    expect("FiLive | Volunteer Log in").to eq(pageTitle)
    expect($session).to have_xpath(@volLogin.emailFieldXpath())
  end

  it "user navigates back to Home page" do
    @common.windowBack()
  end

  after(:all) do
    @common.logoutProcess()
    expect($session).to have_content("Administrator Log In")
  end

end