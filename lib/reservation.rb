module Hotel
  class Reservation
    # @total_cost
    # @dates
    # @room
    # @reservation_id
    attr_reader :total_cost

    def initialize(room, checkin, checkout)
      @room = room
      @checkin = Date.parse(checkin)
      @checkout = Date.parse(checkout)
      get_total
    end

    def get_total
      num_nights = (@checkout - @checkin).to_i
      @total_cost = num_nights * @room.cost
    end

    # def includes_dates?(checkin, checkout)
    # end
  end
end
