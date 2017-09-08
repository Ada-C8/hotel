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
      rooms_available = check_availability(check_in,check_out)

      if rooms_available.length < num_rooms && num_rooms > 20
        raise InvalidRoomQuantity.new("Unfortunately the hotel does not have enough available rooms, in your date range, to handle your request of #{num_rooms} rooms.")
      end
      #rooms needs to be an arry of rooms
      rooms_to_book = rooms_available.shift(num_rooms)
      booking = Booking.new(id,rooms_to_book,date_range)
      @all_reservations << booking
      return booking
    end

    def check_reservations(check_in,check_out)
      booked_rooms = []
      range = DateRange.new(check_in,check_out).nights_arr

      range.each do |date|
        @all_reservations.each do |booking|
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
      booked_rooms =
      available_rooms = []
      check_reservations(check_in,check_out)

      all_rooms.each do |room|
        if !(booked_rooms.include?(room))
          available_rooms << room
        end
      end
      return available_rooms
    end
  end
end
