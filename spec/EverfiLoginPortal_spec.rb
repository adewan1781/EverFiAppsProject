require 'rspec'
require 'spec_helper.rb'


describe "successfully login into customer admin portal",:login do
  
      it "allows to select language as spanish" do
        $session.find(:css, "div[id*=\"targetLanguage\"]").click()
        $session.within_frame 0 do
          expect($session).to have_content("Spanish")
          $session.find(:css, "a[class=\"goog-te-menu2-item\"]").click()
        end
        expect($session).to have_content("Administrador de sesión")
        $session.find(:css, "div[id*=\"targetLanguage\"]").click()
        $session.within_frame 1 do
          expect($session).to have_content("English ")
          $session.find(:css, "a[class=\"goog-te-menu2-item\"]").click()
        end
        expect($session).to have_content("Administrator Log In")
      end
  
      it "allows user to change password" do
        $session.find(:xpath, "//div[@class='forgot-password-form-link']/a").click()
        expect($session).to have_content("Forgot your password?")
        $session.evaluate_script('window.history.back()')
    
      end
      
      it"allows to enter username and password" do
        TestHelper.loginProcess()
        $session.find(:css, "a[href=\"/cportal/ccdee586\"]").click()
        sleep 2
      end
      
  after(:all) do
      TestHelper.logoutProcess()
    expect($session).to have_content("Administrator Log In")
    end
    end