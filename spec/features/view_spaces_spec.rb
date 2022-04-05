feature 'viewing spaces' do
  it 'views spaces' do
  result = DatabaseConnection.query("INSERT INTO spaces (name, description, price_per_night) VALUES($1, $2, $3);", ['aa', 'bb', "20"])
  visit '/spaces'
  expect(page).to have_content("aa")
  end
end
