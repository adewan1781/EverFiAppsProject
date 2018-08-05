require 'rspec'
require 'spec_helper.rb'
require $TEST_BASE+'/../pages/EverfiPageCommon.rb'
require $TEST_BASE+'/../pages/EverfiCommonTabs.rb'
require $TEST_BASE+'/../pages/EverfiTrainingSessionsPage.rb'

@@codeValue = nil
describe "verify training list on Training Sessions tab",:trlist do

  before(:all) do
    @common = EverfiPageCommon.new($session)
    @tabs = EverfiCommonTabs.new($session)
    @trainingPage = EverfiTrainingSessionsPage.new($session)
    @common.loginProcess()

  end

  it "user navigates to Training Sessions Tab" do
    @tabs.clickTrainingSessionsTab()
    pageHeading = @common.findPageHeaderText()
    expect(pageHeading).to include("Training Sessions")
  end

  it "user verifies Training Sessions list is displayed" do
    expect($session).to have_css(@common.productListCss())
    expect($session).to have_xpath(@trainingPage.sessionRowXpath(), :between => 5..26)

  end

  it "user clicks on Add new Training session" do
    @trainingPage.clickOnAddNewSession()
    pageHeading = @common.findPageHeaderText()
    expect(pageHeading).to include("New Training Session")
    expect($session).to have_css(@trainingPage.newTrainingSessionInputFieldCss())
  end

  it "user fills and save the new Training Form" do
    @@codeValue = @trainingPage.fillNewTrainingSessionForm()
    @trainingPage.saveNewTrainingSessionForm()
  end

  it "user navigates to Training Sessions Tab" do
    @tabs.clickTrainingSessionsTab()
    pageHeading = @common.findPageHeaderText()
    expect(pageHeading).to include("Training Sessions")
  end

  it "user searches for the created Training session in list" do
    sessionPageXpath = @trainingPage .searchTrainingSession(@@codeValue)
    expect($session).to have_xpath(sessionPageXpath)

  end

  it "user clicks on Volunteers Count in created training session" do
    @trainingPage.clickVolunteerCount(@@codeValue)
  end

  it"user verifies volunteer tab with volunteer count is displayed" do
    expect($session).to have_xpath(@trainingPage.volunteerTabXpath())
    @@volunteerCountValue =  @trainingPage.verifyVolunteerTabAndCount()
    expect(TestHelper.is_numeric(@@volunteerCountValue)).to be true
  end

  it "user clicks on Add Volunteer button on Manage Session Page" do
    @trainingPage.clickAddVolunteerSession()

  end

  it "user selects the existing Volunteer to add in session" do
    countValue = @trainingPage.addExistingVolunteer()
    expect(Integer(countValue)).to eql(Integer(@@volunteerCountValue)+1)
    @@volunteerCountValue = countValue
  end

  it "user clicks on Add Volunteer button on Manage Session Page" do
    @trainingPage.clickAddVolunteerSession()
  end

  it "user creates the new Volunteer to add in session" do
    countValue = @trainingPage.createNewVolunteerSession()
    expect(Integer(countValue)).to eql(Integer(@@volunteerCountValue)+1)
    @@volunteerCountValue = countValue
  end

  it "user navigates to Training Sessions Tab" do
    @tabs.clickTrainingSessionsTab()
    pageHeading = @common.findPageHeaderText()
    expect(pageHeading).to include("Training Sessions")
  end

  it "user searches for the created Training session in list" do
    sessionPageXpath = @trainingPage .searchTrainingSession(@@codeValue)
    expect($session).to have_xpath(sessionPageXpath)
  end

  it "user clicks on Attendees Count in created training session" do
   @trainingPage.clickAttendeeCount(@@codeValue)
  end

  it"user verifies Attendees tab with Attendees count is displayed" do
    expect($session).to have_xpath(@trainingPage.attendeeTabXpath())
    @@attendeesCountValue =  @trainingPage.verifyAttendeeTabAndCount()
    expect(TestHelper.is_numeric(@@attendeesCountValue)).to be true
  end

  it "user clicks on Add Attendee button on Manage Session Page" do
    @trainingPage.clickAddAttendeeSession()

  end

  it "user fills the new Attendee form and save it" do
    msgDialogXpath = @trainingPage.createNewAttendeeSession()
    expect($session).to have_xpath(msgDialogXpath)
  end

  it "user navigates to training session management page" do
    @trainingPage.navigateBackToSessionManage(@@codeValue)
    expect($session).to have_xpath(@trainingPage.volunteerTabXpath())
    expect($session).to have_xpath(@trainingPage.attendeeTabXpath())
  end

  it "user edit the created attendee and update" do
  @trainingPage.updateAttendee()
  end

  it "user verifies the updated attendee and navigates to session management page" do
    expect($session).to have_xpath(@trainingPage.attendeeUpdatedDialogXpath())
    @trainingPage.navigateBackToSessionManage(@@codeValue)
    expect($session).to have_xpath(@trainingPage.attendeeTabXpath())

  end

  it "user edit the created attendee and change the training session" do
   @trainingPage.updateAttendeeTrainingSession()

  end

  it "user verifies that attendee moved to different training session" do
    expect($session).to have_xpath(@trainingPage.attendeeUpdatedDialogXpath())
    expect($session).to have_xpath(@trainingPage.verifyTrainingSessionXPath(@@codeValue), :count => 0)
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