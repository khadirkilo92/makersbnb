require 'booking'
require 'pg'
require 'database_helpers'
require 'space'
require './spec/login_helper.rb'

describe Booking do
  it 'creates a booking instance when a user makes a booking' do
    result = DatabaseConnection.query("INSERT INTO spaces (name, description, price_per_night) VALUES($1, $2, $3);", ['Makers Mansion', 'bb', 1000])
    booking = Booking.create(username: 'leigh@hotmail.com', id: 1)

    expect(booking).to be_a Booking  
    expect(booking.username).to eq 'leigh@hotmail.com'
    expect(booking.name).to eq 'Makers Mansion'
  end
end
