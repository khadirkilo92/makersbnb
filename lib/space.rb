class Space
  attr_reader :id, :name, :description, :price_per_night

  def initialize(id:, name:, description:, price_per_night:)
      @id  = id
      @name = name
      @description = description
      @price_per_night = price_per_night
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    result = connection.exec('SELECT * FROM spaces;')
    result.map do |space|
      Space.new(id: space['id'], name: space['name'], description: space['description'], price_per_night: space['price_per_night'])
    end
  end

  def self.create(name:, description:, price_per_night:)
    result = DatabaseConnection.query(
      "INSERT INTO spaces (name, description, price_per_night) VALUES($1, $2, $3) RETURNING id, name, description, price_per_night;", [name, description, price_per_night]
    )
    Space.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price_per_night: result[0]['price_per_night'] )
  end

  def self.find(id:)
    result = DatabaseConnection.query(
      "SELECT * FROM spaces WHERE id = $1;", [id]
    )
    Space.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price_per_night: result[0]['price_per_night'])
  end
end 
