require 'date'
require_relative 'date_range'
require_relative 'room'

module Hotel
  class Reservation
    COST = 200 # per night
    attr_reader :guest_name, :dates, :room

    def initialize(guest_name, check_in, check_out)
      @guest_name = guest_name
      @dates = Hotel::DateRange.new(check_in, check_out)
      @room = Hotel::Room.new
    end # end initialize

    def reserve_dates
      @dates.find_range

    end # end #reserve_dates
  end # end of Reservation
end # end of Hotel module
