require_relative '../login_helper.rb'

feature 'return button' do
  it 'returns the user from the preview page to the spaces page' do
    test_login
    result = DatabaseConnection.query("INSERT INTO spaces (name, description, price_per_night) VALUES($1, $2, $3);", ['1 bed flat', 'abc', "100"])
    visit '/spaces'
    first('.space')
    click_button 'Book now'
    click_button 'Go Back'
    expect(current_path).to eq '/spaces'
  end
end
