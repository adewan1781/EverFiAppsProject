require 'rspec'
require 'spec_helper.rb'
require $TEST_BASE+'/../pages/EverfiPageCommon.rb'
require $TEST_BASE+'/../pages/EverfiCommonTabs.rb'
require $TEST_BASE+'/../pages/EverfiVolunteerPage.rb'

describe "verify volunteer tab in Everfi admin portal",:volunteertab do
  before(:all) do
    @common = EverfiPageCommon.new($session)
    @tabs = EverfiCommonTabs.new($session)
    @volunteer = EverfiVolunteerPage.new($session)
    @common.loginProcess()
  end

  it "user navigates to Volunteers Tab" do
    @tabs.clickVolunteersTab()
    pageHeading = @common.findPageHeaderText()
    expect(pageHeading).to include("Volunteers")
  end

  it "user verifies Volunteers list is displayed" do
    expect($session).to have_css(@common.productListCss())
    expect($session).to have_xpath(@volunteer.volunteerRowXpath(), :between => 3..26)
  end

  it "user can not edit the volunteers" do
    rowText = @volunteer.volunteerRowText()
    expect(rowText).not_to include("Edit")
  end

  it"user can delete the volunteer" do
    elementCount = @volunteer.volunteerRowsCount()
    deleteBtnCount = @volunteer.deleteBtnCountInVolunteerRows()
    expect(elementCount).to eq(deleteBtnCount)
  end

  it "user clicks on Add Volunteer button on Volunteer List Page" do
    @volunteer.clickAddVolunteer()

  end

  it "user creates the new Volunteer to add in session" do
    @volunteer.fillValuesAndCreateVolunteeer()
    expect($session).to have_xpath(@volunteer.confirmVolunteerAddedXpath())
    sleep 2
  end

  it "user navigates to Volunteers Tab" do
    @tabs.clickVolunteersTab()
    pageHeading = @common.findPageHeaderText()
    expect(pageHeading).to include("Volunteers")
  end

  it "user clicks on created volunteer from the list" do
    @volunteer.clickOnVolunteerFromList("AVolunteer")
    pageHeading = @common.findPageHeaderText()
    expect(pageHeading).to include("ATester AVolunteer")
  end

  it "user verifies Upcoming Sessions Tab" do
    title = @volunteer.clickAndGetTextFromUpComingTab()
    expect(title).to include("Upcoming Sessions")

  end

  it "user verifies Past Sessions Tab" do
   title = @volunteer.clickAndGetTextFromPastSessionsTab()
    expect(title).to include("Past Sessions")
  end

  it "user deletes the created volunteer" do
    @volunteer.deleteProcess()
    expect($session).to have_xpath("//div[@role='alertdialog'][text()='Volunteer removed.']")
  end

  after(:all) do
    @common.logoutProcess()
    expect($session).to have_content("Administrator Log In")
  end

end