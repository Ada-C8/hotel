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
#TODO create room method for addind nights_reserved
      @room.nights_reserved += date_range(check_in_date, nights)
    end # initialize

    def cost
      cost = nights * room.rate
      return cost
    end # cost

  end # Reservation class

end # ReservationSystem module
