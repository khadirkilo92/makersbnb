require 'database_connection'

class User

  def self.authenticate(email, password)
    self.match_password(fetch_password(email), password)
  end

  def self.fetch_password(email)
    result = DatabaseConnection.query(
    "SELECT password FROM users WHERE email = $1;", [email]
  )
    result.map {|i| {"password" => i["password"]}}
    result[0]["password"]
  end

  def self.match_password(correct_password, password_to_check)
    correct_password == password_to_check
  end
end
