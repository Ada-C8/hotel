require 'date'

module Administration
  class Hotel

    attr_reader :all_rooms

    def initialize(rooms)
      i = 0
      @all_rooms = Array.new(rooms) {|i| i+1}
      @all_reservations = []
    end

    def all_reservations
      return @all_reservations
    end

    def listing_rooms
      return @all_rooms
    end

    def make_reservation(check_in, check_out, room)
      reservation = Reservation.new(check_in, check_out, room)
      @all_reservations.each do |existing|
        if reservation.overlap?(existing)
          return false
        end
      end
      @all_reservations << reservation
      return true
    end







  end #end of class
end #end of hotel
