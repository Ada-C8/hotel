require "date"
require_relative "room"

require "pry"

module Hotel
  class Reservation
    attr_accessor :dates, :room_number

    def initialize(dates, room_number)
      @room_number = room_number
      @dates = dates
    end

    def total
      return "$#{(dates.check_out - dates.check_in).floor * 200}.00"
    end

  end
end
