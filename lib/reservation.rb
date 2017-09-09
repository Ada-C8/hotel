require_relative 'range'

module Property

  class Reservation < Range

  attr_reader :room, :price

    def initialize(room, check_in, check_out, price)
      @room = room
      @price = 200
      # @dates = Property::Range.new(check_in, check_out)
      # @total_price = @dates.num_nights * 200
      super(check_in, check_out)
    end

    def total_price
      return num_nights * @price
    end
  end
end
