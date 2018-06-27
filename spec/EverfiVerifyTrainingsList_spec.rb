require 'rspec'
require 'spec_helper.rb'

describe "verify training list on Training Sessions tab",:trlist do
  
  before(:all) do
    TestHelper.loginProcess()
  end
  
  it "user navigates to Training Sessions Tab" do
    $session.find(:xpath, "//ul[@id='side-menu']//a[contains(@href,'/ccdee586/training_sessions')]").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("Training Sessions")
   end
   
   it "user verifies Training Sessions list is displayed" do
     expect($session).to have_css("div[class=\"project-list\"]")
     expect($session).to have_xpath("//div[@class='project-list']//tr[@data-record-id]", :between => 5..26)
     
   end
    
  after(:all) do
    TestHelper.logoutProcess()
    expect($session).to have_content("Administrator Log In")
  end
  
end