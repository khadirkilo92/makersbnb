feature 'return button' do
  it 'returns the user to the spaces page' do
    result = DatabaseConnection.query("INSERT INTO spaces (name, description, price_per_night) VALUES($1, $2, $3);", ['1 bed flat', 'abc', "100"])
    visit '/spaces'
    click_button 'Book now'
    expect(current_path).to eq '/booking_preview'
    click_button 'Go Back'
    expect(current_path).to eq '/spaces'

  end
end