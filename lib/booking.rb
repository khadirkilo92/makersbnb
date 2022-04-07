class Booking
  attr_reader :username, :id, :name, :description, :total_price

  def initialize(username:, name:, description:, price_per_night:)
      @username = username
      @name = name
      @description = description
      @price_per_night = price_per_night
      @total_price = price_per_night
  end

  def self.create(username:, id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    
    space = Space.find(id: id)

    result = DatabaseConnection.query(
      "INSERT INTO bookings (username, name, description, price_per_night) VALUES($1, $2, $3, $4) RETURNING username, name, description, price_per_night;", [username, space.name, space.description, space.price_per_night]
    )

    result.map { |i| {"username" => i['username'], "name" => i['name'], "description" => i['description'], 'price_per_night' => i['price_per_night']} }
    
    Booking.new(username: result[0]['username'], name: result[0]['name'], description: result[0]['description'], price_per_night: result[0]['price_per_night'])
  end

end