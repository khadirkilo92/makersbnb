require 'user'
require 'pg'

RSpec.describe User do
  it 'matches given password to the stored password in the database' do
    connection = PG.connect(dbname: "makersbnb_test")
    connection.exec_params(
      "INSERT INTO users (email, password) VALUES ($1, $2);",
      ["123@gmail.com", "hello"]
    )
    expect(User.authenticate("123@gmail.com", "hello")).to eq true
  end

  it 'returns false if password is incorrect' do
    connection = PG.connect(dbname: "makersbnb_test")
    connection.exec_params(
      "INSERT INTO users (email, password) VALUES ($1, $2);",
      ["123@gmail.com", "hello"]
    )
    expect(User.authenticate("123@gmail.com", "goodbye")).to eq false
  end

  it 'gets the correct password from the database' do
    connection = PG.connect(dbname: "makersbnb_test")
    connection.exec_params(
      "INSERT INTO users (email, password) VALUES ($1, $2);",
      ["456@gmail.com", "password123"]
    )
    expect(User.fetch_password("456@gmail.com")).to eq "password123"
  end

  it 'matches a given password to the password in the database' do
    connection = PG.connect(dbname: "makersbnb_test")
    connection.exec_params(
      "INSERT INTO users (email, password) VALUES ($1, $2);",
      ["456@gmail.com", "password123"]
    )
    expect(User.match_password("password123", "password123")).to eq true
    expect(User.match_password("password123", "password456")).to eq false
  end

  it 'adds a new user' do
    User.add("leigh@hotmail.com", "goodbye")
    expect(User.fetch_password("leigh@hotmail.com")).to eq "goodbye"
  end
end
