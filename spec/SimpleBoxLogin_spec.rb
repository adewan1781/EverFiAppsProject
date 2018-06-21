require 'rspec'
require 'spec_helper.rb'

describe "login into box"do
      it"allows to enter username and password" do
        $session.visit 'https://app.box.com'
        $session.fill_in('login', :with => "nancydhingra131@gmail.com") 
        sleep 5
      end
    end