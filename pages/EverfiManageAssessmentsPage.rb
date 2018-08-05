class EverfiManageAssessmentsPage
  def initialize(session)
    @session = session
    @util = FrameworkUtilities.new()
  end

  def selectPreAssessment()
    @session.select 'How Businesses Use Credit PRE ASSESSMENT', from: 'modules'

  end

  def addRecordForNewAttendee()
#    @session.find(:css, "span[ id=\"select2-assessment-attendee-container\"]").click()
#    using_wait_time 2 do
#      @session.find(:css, "input[class=\"select2-search__field\"]").send_keys "TestAttendee Person\n"
#    end
    @session.find(:xpath, "//td[contains(@class,'assessment-q-1')]//select[contains(@class,'new-row notranslate')]/option[text()='A']").click()
    @session.find(:xpath, "//td[contains(@class,'assessment-q-2')]//select[contains(@class,'new-row notranslate')]/option[text()='A']").click()
    @session.find(:xpath, "//td[contains(@class,'assessment-q-3')]//select[contains(@class,'new-row notranslate')]/option[text()='A']").click()
    @session.find(:xpath, "//td[contains(@class,'assessment-q-4')]//select[contains(@class,'new-row notranslate')]/option[text()='A']").click()
    @session.find(:xpath, "//td[contains(@class,'assessment-q-5')]//select[contains(@class,'new-row notranslate')]/option[text()='A']").click()
    @session.find(:css, "input[value=\"Save\"]").click()
  end

  def verifyNewAttendeeAssessmentsMessage()
    msg = "//table[contains(@class,'assessment-table completed-row')][.//tr[@id='content-row']//span[text()='TestAttendee Person']]//tr//small[contains(text(),'Submitted via Assessment Entry in Portal.')]"
    msg
  end

  def editRecordForExistingAttendee()
    myArray = ["A", "B", "C", "D"]
    item = myArray.sample()
    $session.find(:xpath, "//div[@id='assessments'][last()]//td[contains(@class,'assessment-q-5')]//select[contains(@class,'existing-row notranslate')]/option[text()='"+item+"']").click()
    $session.find(:css, "input[value=\"Save\"]").click()
  end

  def verifyExistingAttendeeAssessmentModified()
    msg = "//div[@id='assessments'][last()]/table[contains(@class,'assessment-table completed-row')][last()]//tr//small[contains(text(),'Submitted via Assessment Entry in Portal.')]"
    msg
  end

  def selectPostAssessment()
    @session.select 'How Businesses Use Credit POST ASSESSMENT', from: 'modules'
  end

  def clickNewAttendeeSelect()
    @session.find(:css, "span[ id=\"select2-assessment-attendee-container\"]").click()
  end

  def inputNewAttendeeName()
    @session.find(:css, "input[class=\"select2-search__field\"]").send_keys "TestAttendee Person\n"
  end
  def deleteAttendeeFromSession()
    $session.find(:xpath, "//a[@href='#attendees'][@data-toggle='tab']").click()
    $session.find(:xpath, "//table[contains(@class,'table-crud')]//tr[1]//a[@data-method='delete'][contains(@href,'attendees')]").click()
  end

end