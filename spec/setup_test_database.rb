require 'pg'

p "Setting Test Database"

def setup_test_database
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("TRUNCATE spaces, users;")
end
