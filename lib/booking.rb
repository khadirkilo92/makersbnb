class Booking
  attr_reader :name, :description, :price_per_night, :total_price

  def initialize(name:, description:, price_per_night:)
      @name = name
      @description = description
      @price_per_night = price_per_night
      @total_price = price_per_night

  # def self
  #   Booking.new(name, description, price_per_night, total_price)
  # end
  end
end
