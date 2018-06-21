require 'rspec'
require 'spec_helper.rb'



describe "verify tabs in Everfi admin portal",:verifytabs do
  before(:all) do
    TestHelper.loginProcess()
  end
  
  it "user verifies Home Tab" do
    $session.find(:css, "a[href=\"/cportal/ccdee586\"]").click()
    expect($session).to have_xpath("//a[contains(text(),'New Session')]")
  end
  
  it "user verifies Reports Tab" do
    $session.find(:xpath, "//a[contains(@href,'/ccdee586/customer_reports')]").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect("Reports").to eq(pageHeading)
  end
    
  it "user verifies 'Customer admins' Tab" do
    $session.find(:xpath, "//a[contains(@href,'/ccdee586/customer_admins')]").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("Customer Admins")
    end
    
  it "user verifies 'Training Sessions' Tab" do
    $session.find(:xpath, "//a[contains(@href,'/ccdee586/training_sessions')]").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("Training Sessions")
    end
    
  it "user verifies Volunteers Tab" do
    $session.find(:xpath, "//a[@href='/cportal/ccdee586/volunteers']").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("Volunteers")
  end
  
  it "user verifies Organizations Tab" do
    $session.find(:xpath, "//a[contains(@href,'/ccdee586/volunteers?organization=true')]").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("Organizations")   
  end
    
  it "user verifies SSO Tab" do
    $session.find(:xpath, "//a[contains(@href,'/ccdee586/saml_id_providers')]").click()
        pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
        expect(pageHeading).to include("SAML Id Providers")         
  end
  
  after(:all) do
    TestHelper.logoutProcess()
    $session.should have_content("Administrator Log In")
  end
end
