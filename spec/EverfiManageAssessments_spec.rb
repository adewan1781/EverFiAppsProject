require 'rspec'
require 'spec_helper.rb'

$sessionCode = "c16c2b16"

describe "verify assessments to attendee in Everfi admin portal",:assessments do
  before(:all) do
    TestHelper.loginProcess()
  end

  it "user navigates to Training Sessions Tab" do
    $session.find(:xpath, "//ul[@id='side-menu']//a[contains(@href,'/ccdee586/training_sessions')]").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("Training Sessions")
  end

  it "user searches for the given Training session in list" do
    $session.fill_in('q_code_cont', :with => $sessionCode)
    $session.find(:css, "input[value=\"Search\"]").click()
    expect($session).to have_xpath("//tr[.//a[text()='"+$sessionCode+"']]")
    sleep 5
  end

  it "user clicks on Attendees Count in created training session" do
    $session.find(:xpath, "//tr[.//a[text()='"+$sessionCode+"']]/td[5]/a").click()
  end

  it"user verifies Attendees tab with Attendees count is displayed" do
    expect($session).to have_xpath("//a[@href='#attendees'][@data-toggle='tab']")
    $attendeesCountValue =  $session.find(:xpath, "//a[@href='#attendees'][@data-toggle='tab']/span").text
#    puts "aaaaaaaaaaa   "+ $attendeesCountValue
    expect(TestHelper.is_numeric($attendeesCountValue)).to be true
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

  it "user navigates to session management page" do
    $session.find(:xpath, "//div[@class='breadcrumbs']/a[contains(text(),'"+$sessionCode+"')]").click()
    expect($session).to have_xpath("//a[@href='#volunteers'][@data-toggle='tab']")
    expect($session).to have_xpath("//a[@href='#attendees'][@data-toggle='tab']")

  end

  it "user navigates to Manage Assessments Page" do
    $session.find(:css, "a[href*=\"/assessments\"]").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("Assessments")
  end

  it "user is able to select Pre assessment" do
    $session.select 'How Businesses Use Credit PRE ASSESSMENT', from: 'modules'
    using_wait_time 6 do
      expect($session).to have_css("input[value=\"Save\"]")
    end

  end

  it "user is able to add record for each existing assessment of new Attendee" do
    #    $session.select 'TestAttendee Person', from: 'assessment-attendee'
    $session.find(:css, "span[ id=\"select2-assessment-attendee-container\"]").click()
    $session.find(:css, "input[class=\"select2-search__field\"]").send_keys "TestAttendee Person\n"
    $session.find(:xpath, "//td[contains(@class,'assessment-q-1')]//select[contains(@class,'new-row notranslate')]/option[text()='A']").click()
    $session.find(:xpath, "//td[contains(@class,'assessment-q-2')]//select[contains(@class,'new-row notranslate')]/option[text()='A']").click()
    $session.find(:xpath, "//td[contains(@class,'assessment-q-3')]//select[contains(@class,'new-row notranslate')]/option[text()='A']").click()
    $session.find(:xpath, "//td[contains(@class,'assessment-q-4')]//select[contains(@class,'new-row notranslate')]/option[text()='A']").click()
    $session.find(:xpath, "//td[contains(@class,'assessment-q-5')]//select[contains(@class,'new-row notranslate')]/option[text()='A']").click()
    $session.find(:css, "input[value=\"Save\"]").click()
    using_wait_time 6 do
      expect($session).to have_xpath("//table[contains(@class,'assessment-table completed-row')][.//tr[@id='content-row']//span[text()='TestAttendee Person']]//tr//small[contains(text(),'Submitted via Assessment Entry in Portal.')]")
    end

  end

  it "user is able to edit the existing attendee assessment answers " do
    myArray = ["A", "B", "C", "D"]
    item = myArray.sample()
    $session.find(:xpath, "//div[@id='assessments'][last()]//td[contains(@class,'assessment-q-5')]//select[contains(@class,'existing-row notranslate')]/option[text()='"+item+"']").click()
    $session.find(:css, "input[value=\"Save\"]").click()
    using_wait_time 6 do
      expect($session).to have_xpath("//div[@id='assessments'][last()]/table[contains(@class,'assessment-table completed-row')][last()]//tr//small[contains(text(),'Submitted via Assessment Entry in Portal.')]")
    end
  end

  it "user is able to select Post assessment" do
    $session.select 'How Businesses Use Credit POST ASSESSMENT', from: 'modules'
    using_wait_time 6 do
      expect($session).to have_css("input[value=\"Save\"]")
    end

  end

  it "user is able to add record for each existing assessment of new Attendee" do
    #    $session.select 'TestAttendee Person', from: 'assessment-attendee'
    $session.find(:css, "span[ id=\"select2-assessment-attendee-container\"]").click()
    using_wait_time 2 do
      $session.find(:css, "input[class=\"select2-search__field\"]").send_keys "TestAttendee Person\n"
    end
    
    $session.find(:xpath, "//td[contains(@class,'assessment-q-1')]//select[contains(@class,'new-row notranslate')]/option[text()='A']").click()
    $session.find(:xpath, "//td[contains(@class,'assessment-q-2')]//select[contains(@class,'new-row notranslate')]/option[text()='A']").click()
    $session.find(:xpath, "//td[contains(@class,'assessment-q-3')]//select[contains(@class,'new-row notranslate')]/option[text()='A']").click()
    $session.find(:xpath, "//td[contains(@class,'assessment-q-4')]//select[contains(@class,'new-row notranslate')]/option[text()='A']").click()
    $session.find(:xpath, "//td[contains(@class,'assessment-q-5')]//select[contains(@class,'new-row notranslate')]/option[text()='A']").click()
    $session.find(:css, "input[value=\"Save\"]").click()
    using_wait_time 6 do
      expect($session).to have_xpath("//table[contains(@class,'assessment-table completed-row')][.//tr[@id='content-row']//span[text()='TestAttendee Person']]//tr//small[contains(text(),'Submitted via Assessment Entry in Portal.')]")
    end

  end

  it "user is able to edit the existing attendee assessment answers " do
    myArray = ["A", "B", "C", "D"]
    item = myArray.sample()
    $session.find(:xpath, "//div[@id='assessments'][last()]//td[contains(@class,'assessment-q-5')]//select[contains(@class,'existing-row notranslate')]/option[text()='"+item+"']").click()
    $session.find(:css, "input[value=\"Save\"]").click()
    using_wait_time 6 do
      expect($session).to have_xpath("//div[@id='assessments'][last()]/table[contains(@class,'assessment-table completed-row')][last()]//tr//small[contains(text(),'Submitted via Assessment Entry in Portal.')]")
    end
  end

  it "user navigates to training session management page" do
    $session.find(:xpath, "//div[@class='breadcrumbs']/a[contains(text(),'"+$sessionCode+"')]").click()
    expect($session).to have_xpath("//a[@href='#volunteers'][@data-toggle='tab']")
    expect($session).to have_xpath("//a[@href='#attendees'][@data-toggle='tab']")
    
  end

  it "user deletes the created attendee" do
    $session.find(:xpath, "//a[@href='#attendees'][@data-toggle='tab']").click()
    $session.find(:xpath, "//table[contains(@class,'table-crud')]//tr[1]//a[@data-method='delete'][contains(@href,'attendees')]").click()
    using_wait_time 6 do
      $session.driver.browser.switch_to.alert.accept
    end
    expect($session).to have_xpath("//div[@role='alertdialog'][text()='Attendee removed.']")
    
    sleep 5
  end

  after(:all) do
    TestHelper.logoutProcess()
    expect($session).to have_content("Administrator Log In")
  end

end