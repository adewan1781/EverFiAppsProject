class EverfiTrainingSessionsPage
  def initialize(session)
    @session = session
    @util = FrameworkUtilities.new()
  end

  def sessionRowXpath()
    sessionRowXpath = "//div[@class='project-list']//tr[@data-record-id]"
    sessionRowXpath
  end

  def clickOnAddNewSession()
    @session.find(:xpath, "//a[contains(@href,'training_sessions/new')]").click()
  end

  def newTrainingSessionInputFieldCss()
    inputFieldCss = "input[id=\"training_session_session_date\"]"
    inputFieldCss
  end

  def fillNewTrainingSessionForm()
    currentDate = DateTime.now.strftime('%Y-%m-%d')
    @session.find(:css, "input[id=\"training_session_session_date\"]").send_keys currentDate
    codeValue = @session.find(:css, "input[id=\"training_session_code\"]")[:value]
    @session.find(:css, "input[id=\"training_session_street\"]").send_keys "silicon valley"
    @session.find(:css, "input[id=\"training_session_city\"]").send_keys "california"
    @session.find(:xpath, "//div[contains(@class,'training_session_topic_ids')]//input[@class='select2-search__field']").send_keys "Affordable Housing : Housing1\n"
    codeValue

  end

  def saveNewTrainingSessionForm()
    @session.find(:css, "input[value=\"Create Training session\"]").click()
  end

  def searchTrainingSession(codeValue)
    @session.fill_in('q_code_cont', :with => codeValue)
    @session.find(:css, "input[value=\"Search\"]").click()
    sessionPageXpath = "//tr[.//a[text()='"+codeValue+"']]"
    sessionPageXpath
  end

  def clickVolunteerCount(codeValue)
    @session.find(:xpath, "//tr[.//a[text()='"+codeValue+"']]/td[4]/a").click()
  end

  def volunteerTabXpath()
    vTabXpath = "//a[@href='#volunteers'][@data-toggle='tab']"
  end

  def verifyVolunteerTabAndCount()
    volunteerCountValue =  @session.find(:xpath, "//a[@href='#volunteers'][@data-toggle='tab']/span").text
    volunteerCountValue
  end

  def clickAddVolunteerSession()
    @session.find(:css, "a[href*=\"/volunteer_sessions/new\"]").click()
  end

  def addExistingVolunteer()
    @session.find(:css, "span[id=\"select2-volunteer_session_volunteer_id-container\"]").click()
    @session.find(:css, "input[class=\"select2-search__field\"]").send_keys "Robert\n"
    @session.find(:css, "input[value=\"Add volunteer\"]").click()
    countValue = @session.find(:xpath, "//a[@href='#volunteers'][@data-toggle='tab']/span").text
    countValue
  end

  def createNewVolunteerSession()
    @session.fill_in('volunteer_session_volunteer_first_name', :with => "Tester")
    @session.fill_in('volunteer_session_volunteer_last_name', :with => "Volunteer")
    @session.fill_in('volunteer_session_volunteer_email', :with => "abc@volunteer"+@util.generate_Random_number()+".com")
    @session.fill_in('volunteer_session_volunteer_title', :with => "Test Lead")
    @session.find(:css, "input[value=\"Add volunteer\"]").click()
    countValue = @session.find(:xpath, "//a[@href='#volunteers'][@data-toggle='tab']/span").text
    countValue
  end

  def clickAttendeeCount(codeValue)
    @session.find(:xpath, "//tr[.//a[text()='"+codeValue+"']]/td[5]/a").click()
  end

  def attendeeTabXpath()
    aTabXpath = "//a[@href='#attendees'][@data-toggle='tab']"
  end

  def verifyAttendeeTabAndCount()
    attendeeCountValue =  @session.find(:xpath, "//a[@href='#attendees'][@data-toggle='tab']/span").text
    attendeeCountValue
  end

  def clickAddAttendeeSession()
    @session.find(:css, "a[href*=\"/attendees/new\"]").click()
  end

  def createNewAttendeeSession()
    @session.fill_in('attendee_first_name', :with => "TestAttendee")
    @session.fill_in('attendee_last_name', :with => "Person")
    @session.fill_in('attendee_contact_email', :with => "abc@attendee"+@util.generate_Random_number()+".com")
    @session.select '$0 - $10,000', from: 'attendee_income_level'
    @session.find(:css, "input[value=\"Create Attendee\"]").click()
  end

  def navigateBackToSessionManage(codeValue)
    @session.find(:xpath, "//div[@class='breadcrumbs']/a[contains(text(),'"+codeValue+"')]").click()
  end

  def updateAttendee()
    @session.find(:xpath, "//a[@href='#attendees'][@data-toggle='tab']").click()
    @session.find(:xpath, "//div[@id='attendees']//a[contains(@href,'edit')]").click()
    @session.fill_in('attendee_last_name', :with => "Person123")
    @session.find(:css, "input[value=\"Update Attendee\"]").click()
  end

  def updateAttendeeTrainingSession()
    @session.find(:xpath, "//a[@href='#attendees'][@data-toggle='tab']").click()
    @session.find(:xpath, "//div[@id='attendees']//a[contains(@href,'edit')]").click()
    @session.find(:css, "span[id=\"select2-attendee_training_session_id-container\"]").click()
    @session.find(:css, "input[class=\"select2-search__field\"]").send_keys "2018-06-29\n"
    @session.find(:css, "input[value=\"Update Attendee\"]").click()
  end

  def verifyTrainingSessionXPath(codeValue)
    trainingSessionXpath = "//div[@class='breadcrumbs']/a[contains(text(),'"+codeValue+"')]"
    trainingSessionXpath
  end

  def clickTrainingSessionEdit()
    @session.find(:xpath, "//table[contains(@class,'table-crud')]//a[contains(@href,'edit')]").click()
  end

  def editAndSaveTrainingSession()
    @session.find(:css, "input[id=\"training_session_street\"]").send_keys "silicon valley123"
    @session.find(:css, "input[id=\"training_session_city\"]").send_keys "california123"
    @session.find(:css, "input[value=\"Update Training session\"]").click()
  end
  
  def clickManageAssessmentsButton()
    @session.find(:css, "a[href*=\"/assessments\"]").click()
  end

end