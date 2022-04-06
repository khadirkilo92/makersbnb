feature 'home page' do 
  scenario 'view the home page' do
    visit ('/')
    expect(page).to have_content "Welcome to Makersbnb"
    
    click_button "Log in here"
    expect(current_path).to eq '/log_in'
  end
end