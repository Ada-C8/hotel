require 'date'

module Administration
  class Hotel

    attr_reader :all_rooms

    def initialize(rooms)
      i = 0
      @all_rooms = Array.new(rooms) {|i| i+1}
      @all_reservations = []
    end

    def listing_rooms
      return @all_rooms
    end

    def all_reservations
      @all_reservations = []
      reservation = Administration::Reservation.new(:check_in, :check_out)
      @all_reservations << reservation
      return @all_reservations
    end

    def book_reservation(check_in, check_out, room_num)
      room_num = @all_rooms.sample
      reservation = Reservation.new(check_in, check_out)
      return reservation
    end





  end #end of class
end #end of hotel
