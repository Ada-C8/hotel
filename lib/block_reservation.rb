# block_reservation
require 'date'

module HotelManagment
  class BlockReservation < Reservation

    def initialize(first_name, last_name, check_in_date, check_out_date, room_number)
      super
      @cost = cost
    end

    def block_rate
      nights = @check_out_date - @check_in_date
      @cost = nights.to_i * Block::BLOCKRATE
    end

  end #class end
end #module end
