class EverfiLoginPage
  
  def initialize(session)
    @session = session
    @common = EverfiPageCommon.new(session)
  end

  def selectLanguage(language)
    number = 0
    @session.find(:css, "div[id*=\"targetLanguage\"]").click()
    if language != "Spanish"
      number = 1
    end
    @session.within_frame number do
      @session.find(:css, "a[class=\"goog-te-menu2-item\"]").click()
    end
  end
  
  def clickForgotPasswordLink()
    @session.find(:xpath, "//div[@class='forgot-password-form-link']/a").click()
  end


end