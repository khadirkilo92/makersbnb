require 'pg'

def add_test_user
  connection = PG.connect(dbname: "makersbnb_test")
  connection.exec_params(
    "INSERT INTO users (email, password) VALUES ($1, $2);",
    ["leigh@hotmail.com", "pa55word"]
  )
end

def test_login
  add_test_user
  visit '/login'
  fill_in 'email', with: "leigh@hotmail.com"
  fill_in "password", with: "pa55word"
  click_button 'submit'
end
