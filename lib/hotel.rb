require_relative 'date_range'
module Booking
  class Hotel
    attr_reader :rooms

    def initialize
      @list_of_rooms = [1..20]
      @list_of_reservations = []
    end

    def make_reservation(date_range, room_number)
      

    end


    def list_of_reservations_for_a_date(date)

    end
  end
end
