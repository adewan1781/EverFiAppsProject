require 'rspec'
require 'spec_helper.rb'
require $TEST_BASE+'/../pages/EverfiPageCommon.rb'
require $TEST_BASE+'/../pages/EverfiCommonTabs.rb'
require $TEST_BASE+'/../pages/EverfiHomePage.rb'


describe "verify tabs in Everfi admin portal",:verifytabs do
  before(:all) do
    @common = EverfiPageCommon.new($session)
    @tabs = EverfiCommonTabs.new($session)
    @home = EverfiHomePage.new($session)
    @common.loginProcess()
  end
  
  it "user verifies Home Tab" do
    @tabs.clickHomeTab()
    expect($session).to have_xpath(@home.homePageXpath())
  end
  
  it "user verifies Reports Tab" do
    @tabs.clickReportsTab()
    pageHeading = @common.findPageHeaderText()
    expect("Reports").to eq(pageHeading)
  end
    
  it "user verifies 'Customer admins' Tab" do
    @tabs.clickCustomerAdminsTab()
    pageHeading = @common.findPageHeaderText()
    expect(pageHeading).to include("Customer Admins")
    end
    
  it "user verifies 'Training Sessions' Tab" do
   @tabs.clickTrainingSessionsTab()
    pageHeading = @common.findPageHeaderText()
    expect(pageHeading).to include("Training Sessions")
    end
    
  it "user verifies Volunteers Tab" do
   @tabs.clickVolunteersTab()
    pageHeading = @common.findPageHeaderText()
    expect(pageHeading).to include("Volunteers")
  end
  
  it "user verifies Organizations Tab" do
    @tabs.clickOrganizationsTab()
    pageHeading = @common.findPageHeaderText()
    expect(pageHeading).to include("Organizations")   
  end
    
  it "user verifies SSO Tab" do
    @tabs.clickSSOTab()
    pageHeading = @common.findPageHeaderText()
        expect(pageHeading).to include("SAML Id Providers")         
  end
  
  after(:all) do
    @common.logoutProcess()
    expect($session).to have_content("Administrator Log In")
  end
end
