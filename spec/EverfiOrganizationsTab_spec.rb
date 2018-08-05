require 'rspec'
require 'spec_helper.rb'
require 'rspec'
require 'spec_helper.rb'
require $TEST_BASE+'/../pages/EverfiPageCommon.rb'
require $TEST_BASE+'/../pages/EverfiCommonTabs.rb'

#require $TEST_BASE+'/../pages/EverfiTrainingSessionsPage.rb'

describe "verify Organization tab in Everfi admin portal",:organizationtab do
  before(:all) do
    @common = EverfiPageCommon.new($session)
    @tabs = EverfiCommonTabs.new($session)
    #    @trainingPage = EverfiTrainingSessionsPage.new($session)
    #    @util = FrameworkUtilities.new()
    @common.loginProcess()
  end

  it "user navigates to Organizations Tab" do
    @tabs.clickOrganizationsTab()
    pageHeading = @common.findPageHeaderText()
    expect(pageHeading).to include("Organizations")
  end

  it "user verifies Organization list is displayed" do
    expect($session).to have_css("div[class=\"project-list\"]")
    expect($session).to have_xpath("//div[@class='project-list']//tr[@data-record-id]", :between => 1..26)
  end

  it "user can not edit the Organization" do
    rowText = $session.find(:xpath, "//div[@class='project-list']//tr[@data-record-id][1]").text
    expect(rowText).not_to include("Edit")
  end

  it"user can delete the Organization" do
    elementCount = $session.all(:xpath, "//div[@class='project-list']//tr[@data-record-id]").count
    deleteBtnCount = $session.all(:xpath, "//div[@class='project-list']//tr[@data-record-id]//a[@data-method='delete']").count
    expect(elementCount).to eq(deleteBtnCount)
  end

  it "user clicks on Add Organization button on Organization List Page" do
    $session.find(:css, "a[href*=\"/new?organization\"]").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("New Organization")
  end

  it "user creates the new Organization to add in session" do
    $session.fill_in('volunteer_first_name', :with => "ATest")
    $session.fill_in('volunteer_last_name', :with => "AOrganization")
    $session.fill_in('volunteer_email', :with => "everfi.flive@gmail.com")
    $session.fill_in('volunteer_title', :with => "Test Lead")
    $session.find(:css, "input[value=\"Save\"]").click()
    expect($session).to have_xpath("//div[@role='alertdialog'][text()='Volunteer added.']")
  end

  it "user navigates to Organizations Tab" do
    $session.find(:xpath, "//ul[@id='side-menu']//a[contains(@href,'/ccdee586/volunteers?organization=true')]").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("Organizations")
  end

  it "user clicks on created Organization from the list" do
    $session.find(:xpath, "//div[@class='project-list']//tr[@data-record-id][.//a[text()='AOrganization']][last()]//a[text()='AOrganization']").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("ATest AOrganization")
  end

  it "user deletes the created Organization" do
    $session.find(:xpath, "//a[@data-method='delete'][text()='Delete']").click()
    $session.driver.browser.switch_to.alert.accept
    expect($session).to have_xpath("//div[@role='alertdialog'][text()='Volunteer removed.']")
  end

  it "user verifies the email received" do
    $session.visit 'https://accounts.google.com/ServiceLogin'
    expect($session).to have_css("input[id=\"identifierId\"][name=\"identifier\"]")
    $session.fill_in('identifierId', :with => "everfi.flive")
    $session.find(:css, "div[id=\"identifierNext\"]").click()
    $session.fill_in('password', :with => "testing@123")
    $session.find(:css, "div[id=\"passwordNext\"]").click()
    using_wait_time 6 do
      $session.find(:css, "a[aria-label=\"Google apps\"]").click()
    end
    using_wait_time 6 do
      $session.find(:css, "a[href*=\"mail.google.com/mail\"]").click()
    end
    using_wait_time 10 do
      $session.find(:xpath, "//b[text()='Reset password instructions']").click()
    end
    using_wait_time 6 do
      $session.find(:css, "div[data-tooltip=\"Show trimmed content\"]").click()
      expect($session).to have_xpath("//a[text()='Change my password']")
      expect($session).to have_content("Someone has requested a link to change your password. You can do this through the link below.")
    end
    sleep 5
    $session.visit 'https://staging-bbva.everfiapps-dev.net/cportal/ccdee586'
  end

  after(:all) do
    @common.logoutProcess()
    expect($session).to have_content("Administrator Log In")
  end

end
