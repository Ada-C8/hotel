require 'date'
require_relative 'hotel'

module ReservationSystem

  class Reservation
    attr_reader :check_in, :nights, :dates_reserved

    def initialize(check_in_date, nights)
      @check_in = check_in_date
      @nights = nights
      @dates_reserved = Array.new

      nights.times do |i|
        @dates_reserved << check_in_date + i
      end

    end # initialize

  end # Reservation class

end # ReservationSystem module
