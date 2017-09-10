module Hotel
  class Block

    def initialize(checkin, checkout, rooms_set, price)
      @price_per_night = price
      @days_range = Hotel::DateRange.new(checkin, checkout)
      @rooms_set = rooms_set
    end

    def totalcost_oneroom
      @price_per_night * @days_range.stay_length
    end

    def reserve
      if room_avaliable_block?
        @rooms_set.delete_at(0)
        return @rooms_set
      else
        raise ArgumentError.new("There is not more rooms avaliables in the given block")
      end
    end

    def room_avaliable_block?
      @rooms_set.length > 0 ? true : false
    end



  end #class
end #module
