feature 'return button' do
  xit 'returns the user to the spaces page' do
    result = DatabaseConnection.query("INSERT INTO spaces (name, description, price_per_night) VALUES($1, $2, $3);", ['1 bed flat', 'abc', "100"])
    visit '/spaces'
    first('.space').click_button 'Book now'
    expect(current_path).to eq '/booking_preview/:id'
    click_button 'Go Back'
    expect(current_path).to eq '/spaces'

  end
end