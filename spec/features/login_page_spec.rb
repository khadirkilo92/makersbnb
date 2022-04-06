feature 'login page' do
  it 'visits the login page' do
    visit '/login'
    expect(page).to have_content 'Login'
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
    connection = PG.connect(dbname: "makersbnb_test")
    connection.exec_params(
    "INSERT INTO users (email, password) VALUES ($1, $2);",
    ["leigh@hotmail.com", "pa55word"]
  )
    visit '/login'
    fill_in 'email', with: "leigh@hotmail.com"
    fill_in "password", with: "pa55word"
    click_button 'submit'
    expect(current_path).to eq '/spaces'
  end
end