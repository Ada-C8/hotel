module My_Hotel
  class Reservation

    attr_reader :reservation_id, :date_range, :block_id, :rate, :renter_name

    def initialize(start_date, end_date, block_id = 0, renter_name = "Casper")
      @reservation_id = set_id
      @date_range = Date_Range.date_range(start_date, end_date)
      @block_id = block_id
      @renter_name = renter_name #could be expanded to include more info
    end

    # def set_id
    #   make a random id number for the reservation
    #   make sure it is random
    # end

    # def cost_reservation
    #   number of dates * Room.rate = sum
    # end

    # def cancel_reservation
    # end

    # def self.all #returns a list of all the reservations
    # end

  end
end
