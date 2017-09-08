require 'date'
require_relative 'date_range'
require_relative 'room'

module Hotel
  class Reservation
    COST = 200 # per night
    attr_reader :guest_name, :dates, :room, :reservation

    def initialize(guest_name, check_in, check_out)
      @guest_name = guest_name
      @dates = Hotel::DateRange.new(check_in, check_out)
      @room = Hotel::Room.new

      @reservation = {}
      #reservation: [name: date_range, room, cost]
      #sort_by{|k,v|v}
    end # end initialize

    def reserve_dates
      @dates.length_of_stay
    end # end #reserve_dates

    def final_reservation

    end # end #final_reservation

    def list_by_date
      
    end # end #list_by_date
  end # end of Reservation
end # end of Hotel module
