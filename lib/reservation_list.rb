require 'pry'
require_relative 'reservation'

module Hotel

  class ReservationList #Collection of Reservations

      attr_reader :reservation_list

      def initialize
        @reservation_list = []
      end

      def add(id, day_in, day_out, discount, room)
        @reservation_list << Reservation.new(id, day_in, day_out, discount, room)
      end #add
  end #class
end #module
#binding.pry
