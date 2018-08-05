require 'rspec'
require 'spec_helper.rb'
require $TEST_BASE+'/../pages/EverfiPageCommon.rb'
require $TEST_BASE+'/../pages/EverfiCommonTabs.rb'
require $TEST_BASE+'/../pages/EverfiTrainingSessionsPage.rb'
require $TEST_BASE+'/../pages/EverfiManageAssessmentsPage.rb'

$sessionCode = "c16c2b16"

describe "verify assessments to attendee in Everfi admin portal",:assessments do
  before(:all) do
    @common = EverfiPageCommon.new($session)
    @tabs = EverfiCommonTabs.new($session)
    @trainingPage = EverfiTrainingSessionsPage.new($session)
    @util = FrameworkUtilities.new()
    @assessments = EverfiManageAssessmentsPage.new($session)
    @common.loginProcess()
  end

  it "user navigates to Training Sessions Tab" do
    @tabs.clickTrainingSessionsTab()
    pageHeading = @common.findPageHeaderText()
    expect(pageHeading).to include("Training Sessions")
  end

  it "user searches for the given Training session in list" do
    sessionPageXpath = @trainingPage .searchTrainingSession($sessionCode)
    expect($session).to have_xpath(sessionPageXpath)
    sleep 5
  end

  it "user clicks on Attendees Count in created training session" do
    @trainingPage.clickAttendeeCount($sessionCode)
  end

  it"user verifies Attendees tab with Attendees count is displayed" do
    expect($session).to have_xpath(@trainingPage.attendeeTabXpath())
    @@attendeesCountValue =  @trainingPage.verifyAttendeeTabAndCount()
    expect(@util.is_numeric(@@attendeesCountValue)).to be true
  end

  it "user clicks on Add Attendee button on Manage Session Page" do
    @trainingPage.clickAddAttendeeSession()

  end

  it "user fills the new Attendee form and save it" do
    @trainingPage.createNewAttendeeSession()
    expect($session).to have_xpath(@common.messageDialogXpath("Attendee added."))
  end

  it "user navigates to session management page" do
    @trainingPage.navigateBackToSessionManage($sessionCode)
    expect($session).to have_xpath(@trainingPage.volunteerTabXpath())
    expect($session).to have_xpath(@trainingPage.attendeeTabXpath())

  end

  it "user navigates to Manage Assessments Page" do
    @trainingPage.clickManageAssessmentsButton()
    pageHeading = @common.findPageHeaderText()
    expect(pageHeading).to include("Assessments")
  end

  it "user is able to select Pre assessment" do
    @assessments.selectPreAssessment()
    using_wait_time 6 do
      expect($session).to have_css("input[value=\"Save\"]")
    end
  end

  it "user is able to add record for each existing assessment of new Attendee" do
    @assessments.clickNewAttendeeSelect()
    using_wait_time 2 do
      @assessments.inputNewAttendeeName()
    end
    @assessments.addRecordForNewAttendee()
    using_wait_time 6 do
      expect($session).to have_xpath(@assessments.verifyNewAttendeeAssessmentsMessage())
    end

  end

  it "user is able to edit the existing attendee assessment answers " do
    @assessments.editRecordForExistingAttendee()
    using_wait_time 6 do
      expect($session).to have_xpath(@assessments.verifyExistingAttendeeAssessmentModified())
    end
  end

  it "user is able to select Post assessment" do
    @assessments.selectPostAssessment()
    using_wait_time 6 do
      expect($session).to have_css("input[value=\"Save\"]")
    end

  end

  it "user is able to add record for each existing assessment of new Attendee" do
    @assessments.clickNewAttendeeSelect()
    using_wait_time 2 do
      @assessments.inputNewAttendeeName()
    end
    @assessments.addRecordForNewAttendee()
    using_wait_time 6 do
      expect($session).to have_xpath(@assessments.verifyNewAttendeeAssessmentsMessage())
    end

  end

  it "user is able to edit the existing attendee assessment answers " do
    @assessments.editRecordForExistingAttendee()
    using_wait_time 6 do
      expect($session).to have_xpath(@assessments.verifyExistingAttendeeAssessmentModified())
    end
  end

  it "user navigates to training session management page" do
    @trainingPage.navigateBackToSessionManage($sessionCode)
    expect($session).to have_xpath(@trainingPage.volunteerTabXpath())
    expect($session).to have_xpath(@trainingPage.attendeeTabXpath())

  end

  it "user deletes the created attendee" do
    @assessments.deleteAttendeeFromSession()
    using_wait_time 6 do
      $session.driver.browser.switch_to.alert.accept
    end
    expect($session).to have_xpath(@common.messageDialogXpath("Attendee removed."))

    sleep 5
  end

  after(:all) do
    @common.logoutProcess()
    expect($session).to have_content("Administrator Log In")
  end

end