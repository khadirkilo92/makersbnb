require_relative '../login_helper.rb'

feature 'home page' do 
  scenario 'view the home page' do
    test_login
    visit ('/')
    expect(page).to have_content "Welcome to Makersbnb"
  end
end
