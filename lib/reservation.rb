module Hotel
  class Reservation
    # @total_cost
    # @dates
    # @room
    # @reservation_id

    def initialize(checkin, checkout)
      @checkin = Date.parse(checkin)
      @checkout = Date.parse(checkout)
      # @num_nights = (@checkout - @checkin).to_i
    end
    # #get_total()
  end
end
