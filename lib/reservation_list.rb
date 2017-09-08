require 'pry'
require_relative 'reservation'

module Hotel
  class ReservationList #Collection of Reservations
    attr_reader :reservations

    def initialize
      @reservations = Array.new
    end

    def add(id, room, day_in, day_out)
      #reservations = Array.new
      x = Reservation.new(id, room, day_in, day_out)
      @reservations << x
      # @reservations <<  #adds Reservation to group
      return @reservations
    end
  end
end
binding.pry

      #@@reservations << Reservation.new(id, room, day_in, day_out)
