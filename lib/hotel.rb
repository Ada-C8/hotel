#Hotel.rb
require 'awesome_print'
require 'date'
require 'pry'

module Hotel_Chain
  class MyHotel

    attr_reader :array_of_rooms, :reservations_array, :blocks_array

    def initialize(no_of_rooms = 20)
      @array_of_rooms = Array.new(no_of_rooms)
      no_of_rooms.times do |room|
        @array_of_rooms[room] = Room.new(room+1)
      @reservations_array = []
      @blocks_array = []
      end
    end

    #Method is called to print a list for the administrator
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

    def print_reservations_by_date(date)
      array = []
      reservations_on_date = self.find_reservations_by_date(date)
      reservations_on_date.each do |reservation|
        array  << "Room #{reservation.room.room_id} is reserved from #{reservation.check_in_date} to #{reservation.check_out_date}"
      end
      ap array
      return array
    end

    # admin would enter the following to create a new reservation:
    # hotel.store_reservation(check_in_date, check_out_date)

    #NOTE TO SELF: Do you want to reserve a particular room here or in the reservation method, which now just randomly chooses a room, regardless if it's available or not?
    def store_reservation(check_in_date, check_out_date)
      available_rooms = []
      ap "STORE_RESERVATION START: reservations_array: #{reservations_array}"
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

    def find_rooms_available(check_in_date, check_out_date)
      available_rooms = []
      unavailable_rooms = []

      check_in = Date.strptime(check_in_date, "%m/%d/%Y")
      check_out = Date.strptime(check_out_date, "%m/%d/%Y")

      #ap "Reservations array before finding open rooms: #{@reservations_array}"

      @array_of_rooms.each do |room|
        @reservations_array.each do |reservation|
          # checks for unavailable rooms
          if room.room_id == reservation.room.room_id && reservation.block_reserved == true
            unavailable_rooms << room
            ap "here 1"
          #1
          elsif room.room_id == reservation.room.room_id && reservation.check_in_date < check_in && (reservation.check_out_date < check_out && reservation.check_out_date > check_in)
            unavailable_rooms << room
            ap "here 2"
          #2
          elsif room.room_id == reservation.room.room_id && (reservation.check_in_date < check_out && reservation.check_in_date > check_in) && reservation.check_out_date > check_out
            unavailable_rooms << room
            ap "here 3"
          #3
          elsif room.room_id == reservation.room.room_id && (reservation.check_in_date > check_in && reservation.check_in_date < check_out) && (reservation.check_out_date < check_out && reservation.check_out_date > check_in)
            unavailable_rooms << room
            ap "here 4"
          #4
          elsif room.room_id == reservation.room.room_id && reservation.check_in_date < check_in && reservation.check_out_date > check_out
            unavailable_rooms << room
            ap "here 5"
          #5
          elsif room.room_id == reservation.room.room_id && reservation.check_in_date == check_in
            unavailable_rooms << room
            ap "here 6"
          #6
          elsif room.room_id == reservation.room.room_id && (reservation.check_in_date > check_in && reservation.check_in_date < check_out) && reservation.check_out_date == check_out
            unavailable_rooms << room
            ap "here 7"
          #this else statement can ultimately deleted to save storage space, but for now, it's handy to check the available_rooms array when debugging.
          else
            available_rooms << room
          end
        end
      end
      #ap "available_rooms: #{available_rooms}"
      # puts "***FIND ROOMS AVAILABLE ****"
      ap "unavailable_rooms: #{unavailable_rooms}"
      # puts "***"
      final_available_rooms = @array_of_rooms - unavailable_rooms
      # puts "***"
      # ap "FINAL AVAILABLE ROOMS: #{final_available_rooms}"
      return final_available_rooms
    end


    def reserve_block(party_name, check_in, check_out, no_of_rooms, room_rate)
      local_reservation_array = []
      available_rooms = find_rooms_available(check_in, check_out)
      ap available_rooms
      if available_rooms.length < no_of_rooms
        raise ArgumentError.new("There are not enough rooms available to reserve that block")
      else
        no_of_rooms.times do |room|
          new_reservation = store_reservation(check_in, check_out)
          new_reservation.room.rate = room_rate
          new_reservation.block_reserved = true
          new_reservation.status = "unassigned"
          ap "New reservation: #{new_reservation}"
          @reservations_array << new_reservation
          local_reservation_array << new_reservation
        end
      end
      puts "RESULT:"
      ap "Reservation_array: reservation_array"
      #I passed all these arguments to block becuse I want the block object to have these attributes for ease of reference.
      new_block = Block.new(party_name, check_in, check_out, room_rate, local_reservation_array)
      @blocks_array << new_block
      return new_block
    end

    def find_unassigned_block_reservations
    end

    def assign_block_reservation
    end

    def find_block_reservations_by_partyname
    end

  end #end of class
end #end of module
