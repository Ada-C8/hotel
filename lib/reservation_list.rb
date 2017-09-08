require 'pry'
require_relative 'reservation'

module Hotel
  class ReservationList #Collection of Reservations
      attr_reader :reservation_list
      def initialize
        @reservation_list = []
      end

      def add(id, room, day_in, day_out)
        @reservation_list << Reservation.new(id, room, day_in, day_out) #adds Reservation to group
      end
    #@@reservations = Array.new
    # attr_reader :reservations
    #
    # def initialize
    #   @reservations = Array.new
    # end

    # def self.reservations
    #   return @@reservations
    # end

    # def self.add(id, room, day_in, day_out)
    #   #reservations = Array.new
    #
    #   Hotel.reservations << Reservation.new(id, room, day_in, day_out)
    #   # @reservations <<  #adds Reservation to group
    #   return Hotel.reservations
    # end
  end
end
#binding.pry

      #@@reservations << Reservation.new(id, room, day_in, day_out)
