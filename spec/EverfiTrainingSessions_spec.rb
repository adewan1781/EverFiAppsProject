require 'rspec'
require 'spec_helper.rb'

@@codeValue = nil
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

  it "user clicks on Add new Training session" do
    $session.find(:xpath, "//a[contains(@href,'training_sessions/new')]").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("New Training Session")
    expect($session).to have_css("input[id=\"training_session_session_date\"]")
  end

  it "user fills and save the new Training Form" do
    currentDate = DateTime.now.strftime('%Y-%m-%d')
    $session.find(:css, "input[id=\"training_session_session_date\"]").send_keys currentDate
    codeValue = $session.find(:css, "input[id=\"training_session_code\"]")[:value]
    @@codeValue = codeValue
    $session.find(:css, "input[id=\"training_session_street\"]").send_keys "silicon valley"
    $session.find(:css, "input[id=\"training_session_city\"]").send_keys "california"
    $session.find(:xpath, "//div[contains(@class,'training_session_topic_ids')]//input[@class='select2-search__field']").send_keys "Affordable Housing : Housing1\n"
    $session.find(:css, "input[value=\"Create Training session\"]").click()
  end

  it "user navigates to Training Sessions Tab" do
    $session.find(:xpath, "//ul[@id='side-menu']//a[contains(@href,'/ccdee586/training_sessions')]").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("Training Sessions")
  end

  it "user searches for the created Training session in list" do
    $session.fill_in('q_code_cont', :with => @@codeValue)
    $session.find(:css, "input[value=\"Search\"]").click()
    expect($session).to have_xpath("//tr[.//a[text()='"+@@codeValue+"']]")

  end

  it "user clicks on Volunteers Count in created training session" do
    $session.find(:xpath, "//tr[.//a[text()='"+@@codeValue+"']]/td[4]/a").click()
  end

  it"user verifies volunteer tab with volunteer count is displayed" do
    expect($session).to have_xpath("//a[@href='#volunteers'][@data-toggle='tab']")
    @@volunteerCountValue =  $session.find(:xpath, "//a[@href='#volunteers'][@data-toggle='tab']/span").text
    puts "aaaaaaaaaaa   "+ @@volunteerCountValue
    expect(TestHelper.is_numeric(@@volunteerCountValue)).to be true
  end

  it "user clicks on Add Volunteer button on Manage Session Page" do
    $session.find(:css, "a[href*=\"/volunteer_sessions/new\"]").click()

  end

  it "user selects the existing Volunteer to add in session" do
    $session.find(:css, "span[id=\"select2-volunteer_session_volunteer_id-container\"]").click()
    $session.find(:css, "input[class=\"select2-search__field\"]").send_keys "Robert\n"
    $session.find(:css, "input[value=\"Add volunteer\"]").click()
    countValue = $session.find(:xpath, "//a[@href='#volunteers'][@data-toggle='tab']/span").text
    expect(Integer(countValue)).to eql(Integer(@@volunteerCountValue)+1)
    @@volunteerCountValue = countValue
    #     puts "ccccccccccccccc   "+@@volunteerCountValue

  end

  it "user clicks on Add Volunteer button on Manage Session Page" do
    $session.find(:css, "a[href*=\"/volunteer_sessions/new\"]").click()
  end

  it "user creates the new Volunteer to add in session" do
    $session.fill_in('volunteer_session_volunteer_first_name', :with => "Tester")
    $session.fill_in('volunteer_session_volunteer_last_name', :with => "Volunteer")
    $session.fill_in('volunteer_session_volunteer_email', :with => "abc@volunteer"+TestHelper.generate_Random_number()+".com")
    $session.fill_in('volunteer_session_volunteer_title', :with => "Test Lead")
    $session.find(:css, "input[value=\"Add volunteer\"]").click()
    countValue = $session.find(:xpath, "//a[@href='#volunteers'][@data-toggle='tab']/span").text
    expect(Integer(countValue)).to eql(Integer(@@volunteerCountValue)+1)
    @@volunteerCountValue = countValue
    #    puts "ccccccccccccccc   "+@@volunteerCountValue
    
  end

  it "user navigates to Training Sessions Tab" do
    $session.find(:xpath, "//ul[@id='side-menu']//a[contains(@href,'/ccdee586/training_sessions')]").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("Training Sessions")
  end

  it "user searches for the created Training session in list" do
    $session.fill_in('q_code_cont', :with => @@codeValue)
    $session.find(:css, "input[value=\"Search\"]").click()
    expect($session).to have_xpath("//tr[.//a[text()='"+@@codeValue+"']]")
  end

  it "user clicks on Attendees Count in created training session" do
    $session.find(:xpath, "//tr[.//a[text()='"+@@codeValue+"']]/td[5]/a").click()
  end

  it"user verifies Attendees tab with Attendees count is displayed" do
    expect($session).to have_xpath("//a[@href='#attendees'][@data-toggle='tab']")
    @@attendeesCountValue =  $session.find(:xpath, "//a[@href='#attendees'][@data-toggle='tab']/span").text
#    puts "aaaaaaaaaaa   "+ @@attendeesCountValue
    expect(TestHelper.is_numeric(@@attendeesCountValue)).to be true
  end

  it "user clicks on Add Attendee button on Manage Session Page" do
    $session.find(:css, "a[href*=\"/attendees/new\"]").click()
    
  end
  
 it "user fills the new Attendee form and save it" do 
   $session.fill_in('attendee_first_name', :with => "TestAttendee")
   $session.fill_in('attendee_last_name', :with => "Person")
   $session.fill_in('attendee_contact_email', :with => "abc@attendee"+TestHelper.generate_Random_number()+".com")
   $session.select '$0 - $10,000', from: 'attendee_income_level'
   $session.find(:css, "input[value=\"Create Attendee\"]").click()
   expect($session).to have_xpath("//div[@role='alertdialog'][text()='Attendee added.']")

   
 end
 
 it "user navigates to training session management page" do 
   $session.find(:xpath, "//div[@class='breadcrumbs']/a[contains(text(),'"+@@codeValue+"')]").click()
   expect($session).to have_xpath("//a[@href='#volunteers'][@data-toggle='tab']")
   expect($session).to have_xpath("//a[@href='#attendees'][@data-toggle='tab']")
 end
 
 it "user edit the created attendee and update" do
   $session.find(:xpath, "//a[@href='#attendees'][@data-toggle='tab']").click()
   $session.find(:xpath, "//div[@id='attendees']//a[contains(@href,'edit')]").click()
   $session.fill_in('attendee_last_name', :with => "Person123")
   $session.find(:css, "input[value=\"Update Attendee\"]").click()
   
 end
 
  it "user verifies the updated attendee and navigates to session management page" do 
    expect($session).to have_xpath("//div[@role='alertdialog'][text()='Attendee updated.']")
    $session.find(:xpath, "//div[@class='breadcrumbs']/a[contains(text(),'"+@@codeValue+"')]").click()
    expect($session).to have_xpath("//a[@href='#attendees'][@data-toggle='tab']")
    
  end
  
  it "user edit the created attendee and change the training session" do
    $session.find(:xpath, "//a[@href='#attendees'][@data-toggle='tab']").click()
    $session.find(:xpath, "//div[@id='attendees']//a[contains(@href,'edit')]").click()
    $session.find(:css, "span[id=\"select2-attendee_training_session_id-container\"]").click()
    $session.find(:css, "input[class=\"select2-search__field\"]").send_keys "2018-06-29\n"
    $session.find(:css, "input[value=\"Update Attendee\"]").click()
    
  end
 
 it "user verifies that attendee moved to different training session" do
   expect($session).to have_xpath("//div[@role='alertdialog'][text()='Attendee updated.']")
   expect($session).to have_xpath("//div[@class='breadcrumbs']/a[contains(text(),'"+@@codeValue+"')]", :count => 0)
   
 end
 
 it "user deletes the created attendee" do
   $session.find(:xpath, "//a[@data-method=\"delete\"][text()='Delete']").click()
   $session.driver.browser.switch_to.alert.accept
   expect($session).to have_xpath("//div[@role='alertdialog'][text()='Attendee removed.']")
 end
 
  it "user navigates to Training Sessions Tab" do
     $session.find(:xpath, "//ul[@id='side-menu']//a[contains(@href,'/ccdee586/training_sessions')]").click()
     pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
     expect(pageHeading).to include("Training Sessions")
   end
 
   it "user searches for the created Training session in list" do
     $session.fill_in('q_code_cont', :with => @@codeValue)
     $session.find(:css, "input[value=\"Search\"]").click()
     expect($session).to have_xpath("//tr[.//a[text()='"+@@codeValue+"']]")
   end
 
   it "user clicks on Edit button in created training session" do
     $session.find(:xpath, "//table[contains(@class,'table-crud')]//a[contains(@href,'edit')]").click()
     pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
     expect(pageHeading).to include("Edit session")
   end
   
  it "user edit the training session and save" do
    $session.find(:css, "input[id=\"training_session_street\"]").send_keys "silicon valley123"
    $session.find(:css, "input[id=\"training_session_city\"]").send_keys "california123"
    
    $session.find(:css, "input[value=\"Update Training session\"]").click()
    expect($session).to have_xpath("//div[@role='alertdialog'][text()='Training session updated.']")
  end
 
  it "user deletes the training session" do 
    $session.find(:xpath, "//a[@data-method=\"delete\"][text()='Delete']").click()
    $session.driver.browser.switch_to.alert.accept
    expect($session).to have_xpath("//div[@role='alertdialog'][text()='Training session removed.']")
  end

  after(:all) do
    TestHelper.logoutProcess()
    expect($session).to have_content("Administrator Log In")
  end

end