require_relative 'reservable'
require_relative 'hotel'

module ReservationSystem

  class Reservation
    include Reservable

    attr_reader :check_in, :nights, :dates_reserved, :room, :rate, :cost

    def initialize(check_in_date, nights, room, rate: ReservationSystem::Hotel::BASE_ROOM_RATE)
      @check_in = check_in_date
      @nights = nights
      @room = room
      @rate = rate
      @cost = nights * rate
      @dates_reserved = date_range(check_in_date, nights)

      @room.nights_reserved += date_range(check_in_date, nights)

    end # initialize

  end # Reservation class

end # ReservationSystem module
