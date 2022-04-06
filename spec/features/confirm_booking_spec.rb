feature 'shows the preview page' do
  scenario 'shows the preview confirmation page' do
    result = DatabaseConnection.query("INSERT INTO spaces (name, description, price_per_night) VALUES($1, $2, $3);", ['1 bed flat', 'abc', "100"])
    visit '/spaces'
    click_button 'Book now'
    expect(page).to have_content 'Booking Preview'
    end 
end 