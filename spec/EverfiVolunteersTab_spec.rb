require 'rspec'
require 'spec_helper.rb'

describe "verify volunteer tab in Everfi admin portal",:volunteertab do
  before(:all) do
    TestHelper.loginProcess()
  end

  it "user navigates to Volunteers Tab" do
    $session.find(:xpath, "//a[@href='/cportal/ccdee586/volunteers']").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("Volunteers")
  end

  it "user verifies Volunteers list is displayed" do
    expect($session).to have_css("div[class=\"project-list\"]")
    expect($session).to have_xpath("//div[@class='project-list']//tr[@data-record-id]", :between => 3..26)
  end

  it "user can not edit the volunteers" do
    rowText = $session.find(:xpath, "//div[@class='project-list']//tr[@data-record-id][1]").text
    expect(rowText).not_to include("Edit")
  end

  it"user can delete the volunteer" do
    elementCount = $session.all(:xpath, "//div[@class='project-list']//tr[@data-record-id]").count
    deleteBtnCount = $session.all(:xpath, "//div[@class='project-list']//tr[@data-record-id]//a[@data-method='delete']").count
    expect(elementCount).to eq(deleteBtnCount)
  end

  it "user clicks on Add Volunteer button on Volunteer List Page" do
    $session.find(:css, "a[href*=\"/volunteers/new\"]").click()

  end

  it "user creates the new Volunteer to add in session" do
    $session.fill_in('volunteer_first_name', :with => "ATester")
    $session.fill_in('volunteer_last_name', :with => "AVolunteer")
    $session.fill_in('volunteer_email', :with => "abc@volunteer"+TestHelper.generate_Random_number()+".com")
    $session.fill_in('volunteer_title', :with => "Test Lead")
    $session.find(:css, "input[value=\"Save\"]").click()
    expect($session).to have_xpath("//div[@role='alertdialog'][text()='Volunteer added.']")
    sleep 2
  end

  it "user navigates to Volunteers Tab" do
    $session.find(:xpath, "//ul[@id='side-menu']//a[@href='/cportal/ccdee586/volunteers']").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("Volunteers")
  end

  it "user clicks on created volunteer from the list" do
    $session.find(:xpath, "//div[@class='project-list']//tr[@data-record-id][.//a[text()='AVolunteer']][last()]//a[text()='AVolunteer']").click()
    pageHeading = $session.find(:css, "div[class*=\"page-heading\"]").text
    expect(pageHeading).to include("ATester AVolunteer")
  end

  it "user verifies Upcoming Sessions Tab" do
    element = $session.find(:css, "a[href=\"#upcoming-sessions\"][data-toggle=\"tab\"]")
    element.click()
    title = element.text
    expect(title).to include("Upcoming Sessions")

  end

  it "user verifies Past Sessions Tab" do
    element = $session.find(:css, "a[href=\"#past-sessions\"][data-toggle=\"tab\"]")
    element.click()
    title = element.text
    expect(title).to include("Past Sessions")
  end

  it "user deletes the created volunteer" do
    $session.find(:xpath, "//a[@data-method='delete'][text()='Delete']").click()
    $session.driver.browser.switch_to.alert.accept
    expect($session).to have_xpath("//div[@role='alertdialog'][text()='Volunteer removed.']")
  end

  after(:all) do
    TestHelper.logoutProcess()
    expect($session).to have_content("Administrator Log In")
  end

end