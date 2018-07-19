require $TEST_BASE+'/../pages/EverfiPageCommon.rb'
  
require 'rspec'
require 'spec_helper.rb'
require 'benchmark'
require 'net/http'
require 'net/https'
require "uri"
require 'open-uri'
require 'rubygems'
require 'csv'



describe "verify content in Reports",:reportscontent do
  before(:all) do
    TestHelper.loginProcess()
  end
  
  it "user navigates to Reports page" do
    $session.find(:xpath, "//a[contains(@href,'/ccdee586/customer_reports')]").click()
        pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
        expect("Reports").to eq(pageHeading)
  end
  
  it "user navigates to Attendees Report Form" do
    $session.find(:css, "a[id=\"report-attendees\"]").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("Attendees Report")
    
  end
  
  it "user verifies content in csv attendees report without selecting date range" do 

    url = 'https://staging-bbva.everfiapps-dev.net/cportal/ccdee586/'+
    'customer_reports/attendees?utf8=%E2%9C%93&customer_code=ccdee586&'+
    'customer_report%5Bdate_from%5D=&customer_report%5Bdate_to%5D=&'+
    'customer_report%5Btraining_session_location%5D%5B%5D=&customer_report%'+
    '5Battendee_location%5D%5B%5D=&commit=Download+'
#    $session.visit(url)
    if url =~ URI::regexp
        puts "url correct"
    end
#    uri = URI(url)
#    res = Net::HTTP.get_response(uri)
    
    # Headers
#    res['Set-Cookie']            # => String
#    res.get_fields('set-cookie') # => Array
#    res.to_hash['set-cookie']    # => Array
#    puts "Headers: #{res.to_hash.inspect}"
    
    # Status
#    puts "aaaaaaaaaa   "+res.code       # => '200'
#    puts "messager "+es.message    # => 'OK'
#    puts "class "+res.class.name # => 'HTTPOK'
    
    # Body
#    puts "body "+res.body if res.response_body_permitted?
#    puts TestHelper.fetch(url)
    
    
  end
  
  it "user verifies content in csv attendees report after selecting date range" do 
    
  end
  
  it "user navigates to Reports page" do
#      $session.find(:xpath, "//a[contains(@href,'/ccdee586/customer_reports')]").click()
#      pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
#      expect("Reports").to eq(pageHeading)
    end
  
  it "user navigates to master Attendees Report Form" do
      
  end
    
  it "user verifies content in csv master attendees report without selecting date range" do 
      
  end
    
  it "user verifies content in csv master attendees report after selecting date range" do 
      
  end
  
  it "user navigates to Reports page" do
  #      $session.find(:xpath, "//a[contains(@href,'/ccdee586/customer_reports')]").click()
  #      pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
  #      expect("Reports").to eq(pageHeading)
  end  
  
  it "user navigates to Volunteers Report Form" do
        
  end
  
  it "user verifies content in csv Volunteers report without selecting date range" do 
        
  end
      
  it "user verifies content in csv Volunteers report after selecting date range" do 
        
  end
  
  it "user navigates to Reports page" do
  #      $session.find(:xpath, "//a[contains(@href,'/ccdee586/customer_reports')]").click()
  #      pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
  #      expect("Reports").to eq(pageHeading)
 end
      
  it "user navigates to Volunteer Sessions Report Form" do
          
  end
    
  it "user verifies content in csv Volunteer Sessions report without selecting date range" do 
          
  end
        
  it "user verifies content in csv Volunteer Sessions report after selecting date range" do 
          
  end
  
  it "user navigates to Reports page" do
  #      $session.find(:xpath, "//a[contains(@href,'/ccdee586/customer_reports')]").click()
  #      pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
  #      expect("Reports").to eq(pageHeading)
 end
      
  it "user navigates to Training Sessions Report Form" do
            
  end
      
  it "user verifies content in csv Training Sessions report without selecting date range" do 
            
  end
          
  it "user verifies content in csv Training Sessions report after selecting date range" do 
            
  end
      
  after(:all) do
      TestHelper.logoutProcess()
      expect($session).to have_content("Administrator Log In")
  end
  
end

