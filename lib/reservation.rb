require 'date'
require_relative 'hotel'

module ReservationSystem

  class Reservation
    include Tools

    attr_reader :check_in, :nights, :dates_reserved, :room

    def initialize(check_in_date, nights, room)
      valid_date?(check_in_date)
      positive_integer?(nights)

      @check_in = check_in_date
      @nights = nights
      @room = room
      @dates_reserved = Array.new

      nights.times do |i|
        @dates_reserved << check_in_date + i
        @room.nights_reserved << check_in_date + i
      end

    end # initialize

  end # Reservation class

end # ReservationSystem module
