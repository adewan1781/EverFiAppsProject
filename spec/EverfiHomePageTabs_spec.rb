require 'rspec'
require 'spec_helper.rb'



describe "verify tabs in Everfi Home Page",:hometabs do
  before(:all) do
    TestHelper.loginProcess()
  end
  
  it "user navigates to Home page" do
    $session.find(:css, "a[href=\"/cportal/ccdee586\"]").click()
    expect($session).to have_xpath("//a[contains(text(),'New Session')]")
  end
  
  it "user verifies Upcoming Sessions Tab" do
    element = $session.find(:css, "a[href=\"#upcoming-sessions\"]")
    element.click()
    title = element.text
    expect(title).to include("Upcoming Sessions")
    
  end
  
  it "user verifies Past Sessions Tab" do
    element = $session.find(:css, "a[href=\"#past-sessions\"]")
    element.click()
    title = element.text
    expect(title).to include("Past Sessions")
  end
    
  after(:all) do
      TestHelper.logoutProcess()
    expect($session).to have_content("Administrator Log In")
    end
end