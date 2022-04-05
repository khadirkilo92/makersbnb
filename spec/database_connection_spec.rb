require 'pg'

feature 'database connection' do
  it 'connects to the database' do
    connection = PG.connect(dbname: 'makersbnb_test')
    connection.exec("INSERT INTO spaces (name) VALUES ('aaa');")
    result = connection.exec('SELECT * FROM spaces;')
    result.map { |i| {"id" => i['id'], "name" => i['name'], "description" => i['description'], 'price_per_night' => i['price_per_night'] } }
    expect(result[0]["name"]).to eq "aaa"
  end
end