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

  def find_by_date(date)
    res_by_date = []

    @all_reservations.each do |reservation|
      if reservation.reserved?(date) #asking the reservation if it's reserved without the reservation. would look in this class for the reserved method and not find it
        res_by_date << reservation
      end
    end
    return res_by_date
  end

  def find_rooms(date)
    reservations = find_by_date(date)
    reserved_rooms = reservations.map { |reservation| reservation.room }
    available_rooms = @all_rooms - reserved_rooms
    return available_rooms
  end






  end #end of class
end #end of hotel
