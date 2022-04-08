require_relative './database_connection.rb'
require 'bcrypt'

class User

  def self.authenticate(email, password)
    correct_password = fetch_password(email)
    return false if correct_password.nil?
    self.match_password(correct_password, password)
  end

  def self.fetch_password(email)
    result = DatabaseConnection.query(
    "SELECT password FROM users WHERE email = $1;", [email]
  )
    result.map {|i| {"password" => i["password"]}}
    return if result.count == 0
    result[0]["password"]
  end

  def self.match_password(correct_password, password_to_check)
    correct_password == password_to_check
  end

  def self.add(email, password)
    DatabaseConnection.query(
      "INSERT INTO users (email, password) VALUES ($1, $2);", [email, encrypt_password(password)]
    )
  end

  def self.encrypt_password(password)
    BCrypt::Password.create(password)
  end

  def self.valid_email(email)
    email.match?("@")
  end 
end
