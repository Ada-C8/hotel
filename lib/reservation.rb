module Hotel
  class Reservation
    def initialize(checkin, checkout)
      @price_per_night = 200
      @days_range = Hotel::DateRange.new(checkin, checkout)
    end

    def totalcost
      @price_per_night * @days_range.stay_length
    end


  end #class Reservation
end
