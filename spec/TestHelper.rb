module TestHelper
  def TestHelper.loginProcess()
    $session.fill_in('customer_admin_email', :with => "testuser@test.com")
    $session.fill_in('customer_admin_password', :with => "testing123") 
    $session.find(:css, "input[name=\"commit\"]").click()
  end
  
  def TestHelper.logoutProcess()
    $session.find(:css, "a[data-method=\"delete\"][href*=\"logout\"]").click()
   
  end
  
end