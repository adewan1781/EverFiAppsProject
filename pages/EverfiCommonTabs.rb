class EverfiCommonTabs
  
  def initialize(session)
    @session = session
  end
  
  def clickHomeTab()
    @session.find(:css, "a[href=\"/cportal/ccdee586\"]").click()
  end
  
  def clickReportsTab()
    @session.find(:xpath, "//a[contains(@href,'/ccdee586/customer_reports')]").click()
  end

  def clickTrainingSessionsTab()
    @session.find(:xpath, "//ul[@id='side-menu']//a[contains(@href,'/ccdee586/training_sessions')]").click()
  end
  
  def clickCustomerAdminsTab()
    @session.find(:xpath, "//a[contains(@href,'/ccdee586/customer_admins')]").click()
  end
  
  def clickVolunteersTab()
    $session.find(:xpath, "//a[@href='/cportal/ccdee586/volunteers']").click()
  end
  
  def clickOrganizationsTab()
    $session.find(:xpath, "//a[contains(@href,'/ccdee586/volunteers?organization=true')]").click()
  end
  
  def clickSSOTab()
    $session.find(:xpath, "//a[contains(@href,'/ccdee586/saml_id_providers')]").click()
  end
  
 
  
end