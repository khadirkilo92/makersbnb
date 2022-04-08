require_relative '../login_helper.rb'

feature 'displays past bookings' do
  it 'shows a list of previous bookings' do
    test_login
    bookings = DatabaseConnection.query("INSERT INTO bookings (username, name, description, price_per_night) VALUES($1, $2, $3, $4);", ['leigh@hotmail.com', '1 bed flat', 'abc', "100"])
    visit('/account')

    expect(page).to have_content 'leigh@hotmail.com'
    expect(page).to have_content '1 bed flat'
    expect(page).to have_content 'abc'
  end
end