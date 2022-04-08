require_relative './lib/database_connection.rb'

p "Reading ENVIRONMENT Variable"
if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup('makersbnb_test')
else
  DatabaseConnection.setup('makersbnb')
end
