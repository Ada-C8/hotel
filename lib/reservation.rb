require 'date'
require_relative 'date_range'
require_relative 'room'

module Hotel
  class Reservation

    attr_reader :guest_name, :dates, :room_number

    def initialize(guest_name, check_in, check_out, room_number)
      @guest_name = guest_name
      @dates = Hotel::DateRange.new(check_in, check_out)
      @room_number = Hotel::Room.new(room_number)
    end # end initialize

    def reserve_dates
      @dates.find_range

    end
  end # end of Reservation
end # end of Hotel module
