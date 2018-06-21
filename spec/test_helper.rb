module TestHelper
  def visit_youtube
    $session.visit 'http://www.youtube.com'
  end
  
  def search_for_term(text)
    $session.fill_in('search_query', :with => text)
    $session.click_button('search-icon-legacy')
  end
  
  def verify_I_see(text)
    $session.should have_content(text)
  end
end