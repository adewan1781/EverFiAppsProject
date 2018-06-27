require 'rspec'
require 'spec_helper.rb'


describe "verify volunteers portal on home page",:volunteersHome do
  
  before(:all) do
    TestHelper.loginProcess()
  end
  
  it "user navigates to Home page" do
     $session.find(:css, "a[href=\"/cportal/ccdee586\"]").click()
     expect($session).to have_xpath("//a[contains(text(),'New Session')]")
   end
   
   it "user clicks on Volunteer Portal" do
     expect($session).to have_xpath("//a[text()='volunteer portal']")
     $session.find(:xpath, "//a[text()='volunteer portal']").click()
   end
   
   it "Volunteer portal login page should be displayed" do
     pageTitle =$session.title
     expect("FiLive | Volunteer Log in").to eq(pageTitle)
     expect($session).to have_xpath("//input[@id='volunteer_email']") 
   end
   
  it "user navigates back to Home page" do
    $session.evaluate_script('window.history.back()')
  end
   
  it "user clicks on Volunteer Portal session wizard" do
    expect($session).to have_xpath("//a[text()='volunteer portal session wizard']")
    $session.find(:xpath, "//a[text()='volunteer portal session wizard']").click()
  end 
    
  it "Volunteer portal login page should be displayed" do
    pageTitle =$session.title
    expect("FiLive | Volunteer Log in").to eq(pageTitle)
    expect($session).to have_xpath("//input[@id='volunteer_email']")
  end
   
  it "user navigates back to Home page" do
      $session.evaluate_script('window.history.back()')
  end
   
  after(:all) do
    TestHelper.logoutProcess()
    expect($session).to have_content("Administrator Log In")
  end
  
end