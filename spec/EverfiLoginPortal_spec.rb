require 'rspec'
require 'spec_helper.rb'
require $TEST_BASE+'/../pages/EverfiLoginPage.rb'
require $TEST_BASE+'/../pages/EverfiPageCommon.rb'
require $TEST_BASE+'/../pages/EverfiCommonTabs.rb'

describe "successfully login into customer admin portal",:login do

  before(:all) do
    @loginPage = EverfiLoginPage.new($session)
    @common = EverfiPageCommon.new($session)
    @tabs = EverfiCommonTabs.new($session)
  end

  it "allows to select language as spanish" do
    @loginPage.selectLanguage("Spanish")
    expect($session).to have_content("Administrador de sesión")
    @loginPage.selectLanguage("English ")
    expect($session).to have_content("Administrator Log In")
  end

  it "allows user to change password" do
    @loginPage.clickForgotPasswordLink()
    expect($session).to have_content("Forgot your password?")
    @common.windowBack()

  end

  it"allows to enter username and password" do
    @common.loginProcess()
    @tabs.clickHomeTab()
  end

  after(:all) do
    @common.logoutProcess()
    expect($session).to have_content("Administrator Log In")
  end
end