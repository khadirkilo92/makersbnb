require 'booking'
require 'pg'
require 'database_helpers'
require 'space'
require './spec/login_helper.rb'
require 'database_connection'

describe Booking do
  it 'creates a booking instance when a user makes a booking' do
    space = DatabaseConnection.query("INSERT INTO spaces (name, description, price_per_night) VALUES($1, $2, $3) RETURNING id;", ['Makers Mansion', 'bb', 1000])
    space.map { |i| {"id" => i['id']} }
    booking = Booking.create(username: 'leigh@hotmail.com', space_id: space[0]['id'])

    expect(booking).to be_a Booking  
    expect(booking.username).to eq 'leigh@hotmail.com'
    expect(booking.name).to eq 'Makers Mansion'
  end
end
