require_relative '../login_helper.rb'

feature 'allows the user to see previous bookings' do
  it 'displays a list of previous bookings' do
    result = DatabaseConnection.query("INSERT INTO spaces (name, description, price_per_night) VALUES($1, $2, $3);", ['1 bed flat', 'abc', "100"])
    test_login
    click_button 'Book Now'
    click_button 'Request Booking'
    visit '/your_account'
    expect(page).to have_content '1 bed flat'
  end
end
