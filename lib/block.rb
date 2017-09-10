module Hotel
  class Block

    def initialize(checkin, checkout, rooms_set, price)
      @price_per_night = price
      @days_range = Hotel::DateRange.new(checkin, checkout)
      @rooms_set = rooms_set
    end

    def totalcost
      @price_per_night * @days_range.stay_length
    end

    def reserve
      if @rooms_set.length > 0
        @rooms_set.delete_at(0)
      end
      return @rooms_set
    end

  end #class
end #module
