require 'pg'
require 'database_connection'

feature 'database connection' do
  it 'connects to the database' do
    connection = PG.connect(dbname: 'makersbnb_test')
    connection.exec("INSERT INTO spaces (name) VALUES ('aaa');")
    result = connection.exec('SELECT * FROM spaces;')
    result.map { |i| {"id" => i['id'], "name" => i['name'], "description" => i['description'], 'price_per_night' => i['price_per_night'] } }
    expect(result[0]["name"]).to eq "aaa"
  end
end

RSpec.describe DatabaseConnection do
  it 'adds a space and displays the name' do
    DatabaseConnection.query("INSERT INTO spaces (name) VALUES ('bbb');")
    result = DatabaseConnection.query(
      "SELECT * FROM spaces;",
    )
    result.map { |i| {"id" => i['id'], "name" => i['name'], "description" => i['description'], 'price_per_night' => i['price_per_night'] } }
    expect(result[0]["name"]).to eq "bbb"
  end

  it 'adds a space and displays the description' do
    DatabaseConnection.query("INSERT INTO spaces (price_per_night) VALUES ('30');")
    result = DatabaseConnection.query(
      "SELECT * FROM spaces;",
    )
    result.map { |j| {"id" => j['id'], "name" => j['name'], "description" => j['description'], 'price_per_night' => j['price_per_night'] } }
    expect(result[0]["price_per_night"]).to eq "30"
  end

  # it 'adds spaces' do
  #   DatabaseConnection.
  # end
end
