require 'rspec'
require 'spec_helper.rb'

describe "Searching for a video" do
  it "allows searches for general terms" do
    visit_youtube
    search_for_term("text adventures")
    verify_I_see("GET LAMP: The Text Adventure Documentary")
    puts "Test executed successfully"
  end
    it "allows to navigate to amazon" do
      $session.visit 'https://amazon.com'
      sleep 5
    end
end

