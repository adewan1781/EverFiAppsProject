#-------------------------------------------------------------#
# Summary:  Driver class is used to instantiate browser on local machine or on Sauce Labs.
# Purpose: returns browser instance.
# Author : QASource.
#-------------------------------------------------------------#


  
  #Declaration of singleton Driver class
class Driver

#  $worldMap = nil
  @@inst = nil
  $session = nil
  def self.instance   # Self is a reference to the current object instance.
    @@inst = new unless @@inst
    @@inst

  end

  # Function for initializing the Driver instance.
  def initialize()

  end
  # Function for navigating to passed URL and creating browser instance.
   def navigateTo(browser_instance,url)
     Capybara.default_driver = :selenium

     
     Capybara.register_driver :selenium do |app|
           Capybara::Selenium::Driver.new(app, :browser => :chrome)
        end
#         $worldMap = Hash.new
        $session = Capybara::Session.new(:selenium)
     $session.visit 'https://staging-bbva.everfiapps-dev.net/cportal/ccdee586/login'
   end
     
     


  # Function for navigating to passed URL and creating browser instance.
#  def navigateTo(browser_instance,url)
#    $browser = Watir::Browser.new browser_instance
#    $browser.cookies.clear
#    $browser.goto(url)
#  end

  # Function for closing all the opened browser instances.
  def close_multiple_browsers(browser_instance)

#    if browser_instance == "ie"
#      Sys::ProcTable.ps.each{|ps|
#        if ps.name.downcase==browser_instance+"xplore.exe"
#          Process.kill('KILL',ps.pid)
#        end}
#    end
#    if browser_instance != "ie"
    $browser.close
#    end
  end


end