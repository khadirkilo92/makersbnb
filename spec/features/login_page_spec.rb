require_relative '../login_helper.rb'

feature 'login page' do
  it 'visits the login page' do
    visit '/login'
    expect(page).to have_content 'Welcome to MakersBNB'
  end

  it 'has username field' do
    visit '/login'
    expect(page).to have_field 'email'
  end

  it 'has password field' do
    visit '/login'
    expect(page).to have_field 'password'
  end

  it 'has submit button' do
    visit '/login'
    expect(page).to have_button 'submit'
  end

  it "redirects to login page if user isn't logged in" do
    visit '/spaces'
    expect(current_path).to eq '/login'
  end

  it "logs in a user and takes them to the spaces page" do
    add_test_user
    visit '/login'
    fill_in 'email', with: "leigh@hotmail.com"
    fill_in "password", with: "pa55word"
    click_button 'submit'
    expect(current_path).to eq '/spaces'
  end

  it "has a checkbox to hide the password" do
    visit '/login'
    expect(page).to have_field "Show Password"
  end 

  it "has a link to the sign up page" do 
    visit '/login'
    expect(page).to have_link("Not a member? Click here to sign up!", href: '/signup') 
  end

  it 'rejects an incorrect email' do
    visit '/login'
    fill_in 'email', with: 'asdkfjbasdf@gmail.com'
    fill_in 'password', with: '123'
    click_button 'submit'
    expect(current_path).to eq '/login'
    expect(page).to have_content 'The email or password you entered are incorrect'
  end
end
