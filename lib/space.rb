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
end
