require_relative 'reservable'
require_relative 'hotel'

module ReservationSystem

  class Reservation
    include Reservable

    attr_reader :check_in, :nights, :dates_reserved, :room

    def initialize(check_in_date, nights, room)
      @check_in = check_in_date
      @nights = nights
      @room = room
      @dates_reserved = date_range(check_in_date, nights)

      @room.nights_reserved += date_range(check_in_date, nights)

    end # initialize

  end # Reservation class

end # ReservationSystem module
