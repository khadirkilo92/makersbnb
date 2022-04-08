class Booking
  attr_reader :username, :id, :name, :description, :total_price, :price_per_night

  def initialize(username:, name:, description:, price_per_night:)
      @username = username
      @name = name
      @description = description
      @price_per_night = price_per_night
      @total_price = price_per_night
  end

  def self.create(username:, space_id:)

    space = Space.find(id: space_id)

    result = DatabaseConnection.query(
      "INSERT INTO bookings (username, name, description, price_per_night, space_id) VALUES($1, $2, $3, $4, $5) RETURNING username, name, description, price_per_night, space_id;", [username, space.name, space.description, space.price_per_night, space_id]
    )
    
    result.map { |i| {"username" => i['username'], "name" => i['name'], "description" => i['description'], 'price_per_night' => i['price_per_night']} }

    Booking.new(username: result[0]['username'], name: result[0]['name'], description: result[0]['description'], price_per_night: result[0]['price_per_night'])
  end
end
