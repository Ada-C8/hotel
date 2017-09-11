require 'pry'
require_relative 'reservation'

module Hotel

  class ReservationList

      attr_reader :reservation_list

      def initialize
        @reservation_list = []
      end

      def add(id, day_in, day_out, discount, block_code, room)
        @reservation_list << Reservation.new(id, day_in, day_out, discount, block_code, room)
      end #add
  end #class
end #module
#binding.pry
