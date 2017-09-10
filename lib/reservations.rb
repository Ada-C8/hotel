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
    #def make_block(check_in,check_out,num_rooms)
    # check_availability(check_in,check_out)
    # date_range = DateRange.new(check_in,check_out)

    def make_reservation(check_in,check_out,num_rooms, block_info = [])
      date_range = DateRange.new(check_in,check_out)
      id = (@all_reservations.length + 1)
      rooms_available = check_availability(check_in,check_out)

      # make this in to separate method
      if rooms_available.length < num_rooms || num_rooms > 20
        raise InvalidRoomQuantity.new("Unfortunately the hotel does not have enough available rooms to handle your request of #{num_rooms} rooms.")
      end

      # make this in to separate method
      rooms_to_book = rooms_available.shift(num_rooms)
      # binding.pry
      booking = Booking.new(id,rooms_to_book,date_range, block_info)
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
      booked_rooms = check_reservations(check_in,check_out)
      available_rooms = []
      all_rooms.each do |room|
        if !(booked_rooms.include?(room))
          available_rooms << room
        end
      end
      return available_rooms
    end
  end
end
