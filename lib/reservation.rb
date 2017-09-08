require_relative 'range'

# I can reserve a room for a given date range
# I can access the list of reservations for a specific date
# I can get the total cost for a given reservation


module Property

  class Reservation


    def initialize(block)
      @rooms = []
      @dates = Property::Range.new(check_in, check_out)
      @total_price = @dates.num_nights * 200
      # super(check_in, check_out)
    end
  end
end
