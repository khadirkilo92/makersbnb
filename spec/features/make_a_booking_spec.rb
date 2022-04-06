feature 'making a booking' do
  it 'books a room' do
    result = DatabaseConnection.query("INSERT INTO spaces (name, description, price_per_night) VALUES($1, $2, $3);", ['1 bed flat', 'abc', "100"])
    visit '/spaces'
    expect(page).to have_content("1 bed flat")
    click_button 'Book now'
    expect(page).to have_content("Booking Preview")
  end

  it 'displays information for booking' do
    DatabaseConnection.query("INSERT INTO spaces (name, description, price_per_night) VALUES($1, $2, $3);", ['1 bed flat', 'abc', "100"])
    visit '/spaces'

    expect(page).to have_content("1 bed flat")
    
    first('.space')
    click_button 'Book now'

    expect(page).to have_content "1 bed flat"
    expect(page).to have_content "abc"
    expect(page).to have_content "100"
  end
end