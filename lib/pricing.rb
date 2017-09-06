module Hotel
  class Pricing

    def self.calc_cost(reservation)
      total_nights = reservation.total_nights
      cost = total_nights * 200.0 
      return cost
    end

  end
end
