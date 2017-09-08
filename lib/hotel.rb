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

    #NOTE TO SELF: Do you want to reserve a particular room here or in the reservation method, which now just randomly chooses a room, regardless if it's available or not?
    def store_reservation(check_in_date, check_out_date)
      available_rooms = []
      if @reservations_array.length == 0 #i.e. there are no reservations at all
        new_reservation = Hotel_Chain::Reservation.new(check_in_date, check_out_date)
        new_reservation.room = @array_of_rooms[0]
        @reservations_array << new_reservation
        return new_reservation
        # puts "***STORE RESERVATION - NOTHING IN RESERVATIONS ARRAY ****"
        # ap "new_reservation when it was empty before: #{new_reservation}"
        # ap "new_reservation's room when it was empty before: #{new_reservation.room.room_id}"
        # ap "@reservations_array when it was empty before: #{@reservations_array}"
      elsif @reservations_array.length > 0
        available_rooms = find_rooms_available(check_in_date, check_out_date)
        if available_rooms.length == 0
          raise ReservationNotAvailableError
        else
          new_reservation = Hotel_Chain::Reservation.new(check_in_date, check_out_date)
          new_reservation.room = available_rooms[0]
          @reservations_array << new_reservation
          # puts "***STORE RESERVATION - SOMETHING IN RESERVATIONS ARRAY ****"
          # ap "new_reservation if there was already data: #{new_reservation}"
          # ap "new_reservation's room if there was already data: #{new_reservation.room.room_id}"
          # ap "@reservations_array if there was already data: #{@reservations_array}"
          return new_reservation
        end
      end
    end

    #Finds all reservations for a given date
    def find_reservations_by_date(date)
      reservations_on_date = []
      @reservations_array.each do |reservation|
        if (reservation.check_in_date...reservation.check_out_date).cover?(Date.strptime(date, "%m/%d/%Y"))
          reservations_on_date << reservation
        end
      end
      return reservations_on_date
    end


    def find_rooms_available(check_in_date, check_out_date)
      available_rooms = []
      unavailable_rooms = []

      check_in = Date.strptime(check_in_date, "%m/%d/%Y")
      check_out = Date.strptime(check_out_date, "%m/%d/%Y")

      #ap "Reservations array before finding open rooms: #{@reservations_array}"

      @array_of_rooms.each do |room|
        @reservations_array.each do |reservation|
          # checks for unavailable rooms
          #1
          if room.room_id == reservation.room.room_id && reservation.check_in_date < check_in && (reservation.check_out_date < check_out && reservation.check_out_date > check_in)
            unavailable_rooms << room
          #2
          elsif room.room_id == reservation.room.room_id && (reservation.check_in_date < check_out && reservation.check_in_date > check_in) && reservation.check_out_date > check_out
            unavailable_rooms << room
          #3
          elsif room.room_id == reservation.room.room_id && (reservation.check_in_date > check_in && reservation.check_in_date < check_out) && (reservation.check_out_date < check_out && reservation.check_out_date > check_in)
            unavailable_rooms << room
          #4
          elsif room.room_id == reservation.room.room_id && reservation.check_in_date < check_in && reservation.check_out_date > check_out
            unavailable_rooms << room
          #5
          elsif room.room_id == reservation.room.room_id && reservation.check_in_date == check_in
            unavailable_rooms << room
          #6
          elsif room.room_id == reservation.room.room_id && (reservation.check_in_date > check_in && reservation.check_in_date < check_out) && reservation.check_out_date == check_out
            unavailable_rooms << room
          else
            available_rooms << room
          end
        end
      end
      #ap "available_rooms: #{available_rooms}"
      # puts "***FIND ROOMS AVAILABLE ****"
      # ap "unavailable_rooms: #{unavailable_rooms}"
      # puts "***"
      final_available_rooms = @array_of_rooms - unavailable_rooms
      # puts "***"
      # ap "FINAL AVAILABLE ROOMS: #{final_available_rooms}"
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
