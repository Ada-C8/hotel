module Hotel
  class Reservation
    attr_reader :dates

    ROOMCOST = 200

    def initialize(checkin_date, checkout_date)
      @dates = DateRange.new(checkin_date, checkout_date)
      @num_nights = checkout_date - checkin_date
    end

    def price_night
      total_cost = (@num_nights-1) * ROOMCOST
      return total_cost
    end
  end

end
