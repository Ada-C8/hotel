#Hotel.rb
require 'awesome_print'
require 'date'
require 'pry'

module Hotel_Chain
  class MyHotel

    attr_reader :array_of_rooms, :reservations_array

    def initialize(no_of_rooms = 20)
      @array_of_rooms = Array.new(no_of_rooms)
      no_of_rooms.times do |room|
        @array_of_rooms[room] = Room.new(room+1)
      @reservations_array = []
      end
    end

    #Method is called to print a list for the administrator
    #hotel = Hotel_Chain::MyHotel.new
    #hotel.list_rooms
    def list_rooms
      #myhotel = Hotel_Chain::MyHotel.all
      list_array = []
      i = 0
      @array_of_rooms.each do |object|
          list_array << "#{i+1}. Room #{object.room_id} - $#{object.rate}/night"
          i += 1
      end
      return list_array
    end

    # admin would enter the following to create a new reservation:
    # hotel.store_reservation(check_in_date, check_out_date)
    def store_reservation(check_in_date, check_out_date)
      @reservations_array << Hotel_Chain::Reservation.new(check_in_date, check_out_date)
    end

    #Finds all reservations for a given date
    def find_reservations_by_date(date)
      reservations_on_date = []
      @reservations_array.each do |reservation|
        if (reservation.check_in_date...reservation.check_out_date).cover?(Date.strptime(date, "%m/%d/%Y"))
          reservations_on_date << reservation
        end
      end
      # if reservations_on_date.length == 0
      #   return "There are currently no reservations for #{date}"
      # end
      return reservations_on_date
    end


    #calculate length of stay
    #iterate through reservation to see if it
    def find_rooms_available(check_in_date, check_out_date)
      available_rooms = []
      unavailable_rooms = []

      check_in = Date.strptime(check_in_date, "%m/%d/%Y")
      check_out = Date.strptime(check_out_date, "%m/%d/%Y")
      #length_of_stay = (check_out - check_in).to_i

      #this doesn't work because it only looks at rooms with reservations, if any exist. But if a room doesn't have any reservations at all, it won't look at that room. The test would require it look at reservations for all rooms.
      @array_of_rooms.each do |room|
        @reservations_array.each do |reservation|
          # checks for unavailable rooms
          if room.room_id == reservation.room_id && reservation.check_in_date < check_in && (reservation.check_out_date < check_out && reservation.check_out_date > check_in)
            unavailable_rooms << room
          elsif room.room_id == reservation.room_id && (reservation.check_in_date < check_out && reservation.check_in_date > check_in) && reservation.check_out_date > check_out
            unavailable_rooms << room
          elsif room.room_id == reservation.room_id && (reservation.check_in_date > check_in && reservation.check_in_date < check_out) && (reservation.check_out_date < check_out && reservation.check_out_date > check_in)
            unavailable_rooms << room
          elsif room.room_id == reservation.room_id && reservation.check_in_date < check_in && reservation.check_out_date > check_out
            unavailable_rooms << room
          else
            available_rooms << room
          end
        end
      end
      ap "available_rooms: #{available_rooms}"
      ap "unavailable_rooms: #{unavailable_rooms}"
      unique_available_rooms = available_rooms.uniq
      ap "unique_available_rooms: #{unique_available_rooms}"
      final_available_rooms = unique_available_rooms - unavailable_rooms
      ap "final_available_rooms: #{final_available_rooms}"
      return final_available_rooms
    end




    # def print_reservations_by_date(date)
    #   array = []
    #   reservations_on_date = self.make_reservations_by_date_array(date)
    #   reservations_on_date.each do |reservation|
    #     array  << "Room #{reservation.room_id} is reserved from #{reservation.check_in_date} to #{reservation.check_out_date}"
    #   end
    #   puts array
    # end
  end #end of class
end #end of module
