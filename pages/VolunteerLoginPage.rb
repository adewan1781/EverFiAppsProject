class VolunteerLoginPage
  
  def initialize(session)
      @session = session
    end
    
    def getPageTitle()
      pageTitle =@session.title
      pageTitle
    end
    
    def emailFieldXpath()
      fieldXpath = "//input[@id='volunteer_email']"
      fieldXpath
    end
end