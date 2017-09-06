require 'date'

module Hotel
  class Reservations
    attr_reader :all_rooms, :all_reservations

    def initialize
      @all_rooms = []
      create_rooms

      @all_reservations = []


    end

    def create_rooms
      20.times do |i|
        num = i + 1
        @all_rooms << Room.new(num)
      end
    end


    def make_booking(no_of_rooms, start_date, end_date)

      date_range = DateRange.new(start_date, end_date)
      #this throws error if dates are wrong right away - begin rescue?
      availability = check_availability(start_date, end_date)
      if availability.length < no_of_rooms
        ArgumentError.new "not enough rooms"
      elsif availability == []
        ArgumentError.new "no rooms avail"
      end

      id = @all_reservations.length
      rooms = [@all_rooms[0]]
      no_of_rooms.times do |i|
        rooms << availability[i]
      end

      booking = Booking.new(id, rooms, date_range)
      @all_reservations << booking
      return booking
    end

    def check_reserved(start_date, end_date)
      check_against = DateRange.new(start_date, end_date).nights_arr
      not_available = []

      check_against.each do |date|
      # check_against.each do |index|

        @all_reservations.each do |booking|
          if booking.date_range.include?(date)
            booking.rooms.each do |room|
              not_available << room
            end
          end
        end
      end
      return not_available
    end

    def check_availability(start_date, end_date)
      available = []
      @all_rooms.each do |room|
        if check_reserved(start_date, end_date).include?(room) == false
          available << room
        end
      end
      return available
    end
  end
end
