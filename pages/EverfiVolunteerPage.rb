require File.dirname(__FILE__)+'/../utilities/FrameworkUtilities.rb'

class EverfiVolunteerPage
  def initialize(session)
    @session = session
    @util = FrameworkUtilities.new()
  end

  def volunteerRowXpath()
    volunteerRowXpath = "//div[@class='project-list']//tr[@data-record-id]"
    volunteerRowXpath
  end

  def volunteerRowText()
    rowText = @session.find(:xpath, "//div[@class='project-list']//tr[@data-record-id][1]").text
    rowText
  end

  def volunteerRowsCount()
    elementCount = @session.all(:xpath, "//div[@class='project-list']//tr[@data-record-id]").count
    elementCount
  end

  def deleteBtnCountInVolunteerRows()
    deleteBtnCount = @session.all(:xpath, "//div[@class='project-list']//tr[@data-record-id]//a[@data-method='delete']").count
    deleteBtnCount
  end

  def clickAddVolunteer()
    @session.find(:css, "a[href*=\"/volunteers/new\"]").click()
  end

  def fillValuesAndCreateVolunteeer()
    @session.fill_in('volunteer_first_name', :with => "ATester")
    @session.fill_in('volunteer_last_name', :with => "AVolunteer")
    @session.fill_in('volunteer_email', :with => "abc@volunteer"+@util.generate_Random_number()+".com")
    @session.fill_in('volunteer_title', :with => "Test Lead")
    @session.find(:css, "input[value=\"Save\"]").click()
  end

  def confirmVolunteerAddedXpath()
    dialogXpath = "//div[@role='alertdialog'][text()='Volunteer added.']"
    dialogXpath
  end

  def clickOnVolunteerFromList(volunteerName)
    @session.find(:xpath, "//div[@class='project-list']//tr[@data-record-id][.//a[text()='"+volunteerName+"']][last()]//a[text()='"+volunteerName+"']").click()
  end

  def clickAndGetTextFromUpComingTab()
    element = @session.find(:css, "a[href=\"#upcoming-sessions\"][data-toggle=\"tab\"]")
    element.click()
    title = element.text
    title
  end

  def clickAndGetTextFromPastSessionsTab()
    element = @session.find(:css, "a[href=\"#past-sessions\"][data-toggle=\"tab\"]")
    element.click()
    title = element.text
  end

  def deleteProcess()
    @session.find(:xpath, "//a[@data-method='delete'][text()='Delete']").click()
    @session.driver.browser.switch_to.alert.accept
  end

end