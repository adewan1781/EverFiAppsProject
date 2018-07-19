class EverfiHomePage
  def initialize(session)
    @session = session
  end

  def clickAndGetUpcomingSessionsText()
    element = @session.find(:css, "a[href=\"#upcoming-sessions\"]")
    element.click()
    title = element.text
    title
  end

  def clickAndGetPastSessionsText()
    element = @session.find(:css, "a[href=\"#past-sessions\"]")
    element.click()
    title = element.text
    title
  end
  
  def homePageXpath()
     pageXpath = "//a[contains(text(),'New Session')]"
     pageXpath
   end
   
   def clickVolunteerPortalLink()
     @session.find(:xpath, "//a[text()='volunteer portal']").click()
   end
   
   def clickVolunteerSessionWizardLink()
     @session.find(:xpath, "//a[text()='volunteer portal session wizard']").click()
   end
   
   

end