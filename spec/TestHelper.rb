module TestHelper
  
  
  def TestHelper.loginProcess()
    $session.fill_in('customer_admin_email', :with => "testuser@test.com")
    $session.fill_in('customer_admin_password', :with => "testing123") 
    $session.find(:css, "input[name=\"commit\"]").click()
  end
  
  def TestHelper.logoutProcess()
    $session.find(:css, "a[data-method=\"delete\"][href*=\"logout\"]").click()
   
  end
  
  def TestHelper.is_numeric(o)
     begin
      value = Integer(o)
      return true
     rescue
       return false 
     end
  end
  
  # Creating Random number with required length
   def TestHelper.generate_Random_number()
     randomNo = Random.rand(1000-10) + 10
     number=randomNo.to_s
     return(number)
     end
     
end