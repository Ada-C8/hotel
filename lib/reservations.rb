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

    def make_reservation(check_in,check_out,num_rooms)
      date_range = DateRange.new(check_in,check_out)
      id = (@all_reservations.length + 1)
      booking = Booking.new(id, num_rooms,date_range)

      @all_reservations << booking
      #1 take start_date and end_date and pass it to date range class, date range will validate user input
      #make sure you have enough rooms available

      #2 do we have availability? If yes make a booking.new(range_of_dates) and push to all_reservations
      # check_reservation
      # check_availability
      # Hotel::Booking.new(id, rooms, date_range)
    end

    def check_reservations(check_in,check_out)
      # run through valid_date?
      range = DateRange.new(check_in,check_out).nights_arr
      booked_rooms = []
      # binding.pry
      range.each do |date|
        @all_reservations.each do |booking|
          # binding.pry
          if booking.date_range.nights_arr.include?(date)
            booking.rooms.each do |room|
              if (!booked_rooms.include?(room))
                booked_rooms << room
              end
            end
          end
        end
      end
      return booked_rooms
    end

    def check_availability(check_in,check_out)
      booked_rooms = check_reservations(check_in,check_out)
      available_rooms = []


      # return the inverse not_available

    end
  end
end
