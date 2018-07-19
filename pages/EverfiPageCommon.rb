#require 'rspec'
#require File.dirname(__FILE__)+'/../spec/spec_helper.rb'

class EverfiPageCommon
  def initialize(session)
    @session = session
  end

  def loginProcess()
    @session.fill_in('customer_admin_email', :with => "testuser@test.com")
    @session.fill_in('customer_admin_password', :with => "testing123")
    @session.find(:css, "input[name=\"commit\"]").click()
  end

  def logoutProcess()
    @session.find(:css, "a[data-method=\"delete\"][href*=\"logout\"]").click()

  end

  def windowBack()
    @session.evaluate_script('window.history.back()')
  end
  
  def findPageHeaderText()
     pageHeading = @session.find(:css, "div[class*=\"page-heading\"]").text
     pageHeading
   end

end