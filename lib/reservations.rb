require 'pry'
require 'date'

module Hotel
  class Reservations
    attr_reader :all_rooms, :all_reservations
    def initialize
      @all_rooms = []
      @all_reservations = []
      20.times do |i|
        i += 1
        @all_rooms << Hotel::Room.new(i)
      end
    end
    #@all_rooms - initializes with 20 instances of the room class
    #all_reservations - array of instances of the booking class

    def make_reservation(start_date, end_date)
      #1 take start_date and end_date and pass it to date range class, date range will validate user input

      #2 do we have availability? If yes make a booking.new(range_of_dates) and push to all_reservations
      # check_reservation
      # check_availability
    end

    def check_reservation(start_date, end_date)
      #1 take start_date and end_date and pass it to date range class, date range will validate user input
      #@all_reservations check if each find date
      #if reservation.date.include?(date_range[0])
      #not_available << room
      #return not_available
    end

    def check_availability
      # return the inverse not_available
    end
  end
end
