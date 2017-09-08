require_relative 'reservation'
module My_Hotel
  ROOMS = {1 => 200,
    2 => 200,
    3 => 200,
    4 => 200,
    5 => 200,
    6 => 200,
    7 => 200,
    8 => 200,
    9 => 200,
    10 => 200,
    11 => 200,
    12 => 200,
    13 => 200,
    14 => 200,
    15 => 200,
    16 => 200,
    17 => 200,
    18 => 200,
    19 => 200,
    20 => 200
  }
  class Hotel

    attr_reader :rooms, :all_reservations

    def initialize
      @rooms = ROOMS
      @all_reservations = []
      @all_blocks =[]
    end

    def display_rooms
      ROOMS.keys
    end

    def make_reservation(first_night, last_night)
      new_reservation = My_Hotel::Reservation.new(first_night, last_night)
      rooms_avail = find_unreserved_rooms(first_night..last_night)
      new_reservation.assign_room(rooms_avail)
      new_reservation.set_cost
      new_reservation.set_reservation_id
      while unique_id?(new_reservation) == false
        new_reservation.set_reservation_id
      end
      @all_reservations << new_reservation
      return new_reservation
    end

    def make_block(first_night, last_night, array_of_rooms, discount)
      new_block = My_Hotel::Block.new(first_night, last_night, array_of_rooms, discount)
      #rooms_avail = find_unreserved_rooms(first_night..last_night)
      #new_block.assign_room(rooms_avail)
      #remove those blocks from available rooms
      # new_block.set_cost
      new_block.set_block_id
      while unique_id?(new_block) == false
        new_reservation.set_block_id
      end
      @all_blocks << new_block
      new_block
    end


    def unique_id?(new_reservation)
      if @all_reservations.length != 0
        @all_reservations.each do |one_reservation|
          if one_reservation.reservation_id == new_reservation.reservation_id
            puts one_reservation.reservation_id
            puts new_reservation.reservation_id
            return false
          end
        end
      end
      return true
    end

    #given a range of nights, it will find rooms that are available for every night in the range.
    #if no room is available for the whole range, returns an empty hash
    def find_unreserved_rooms(nights)
      # for each nightof the reservation make an array of the available rooms.
      array_of_rooms = []
      nights.each do |night|
        reservations_on_date = find_reservations_by_date(night)
        free_rooms = ROOMS.dup
        reservations_on_date.each do |reservation|
          free_rooms.delete(reservation.room_number)
        end
        if free_rooms.length == 0
          return {} #If any night has no rooms available, return an empty hash.
        end
        array_of_rooms << free_rooms
      end
      #For each room that is free on the first night, check if it is free on the other nights.
      #Return a hash with all the rooms => prices that are free on all nights.
      #If no room is free on all nights, return an empty hash.
      free_for_range = {}
      array_of_rooms[0].each do |room, cost|
        free = true
        array_of_rooms.each do |free_rooms|
          free = free && (free_rooms[room] != nil)
        end
        if free == true
          free_for_range[room] = cost
        end
      end
      return free_for_range
    end

    #given the reservation_id, returns the reservation if it exists, or nill if it does not
    def find_by_reservation_id(reservation_id)
      @all_reservations.each do |reservation|
        if reservation.reservation_id == reservation_id
          return reservation
        end
      end
      return nil
    end

    def find_by_block_id(block_id)
      @all_reservations.each do |reservation|
        if reservation.block_id == block_id
          return reservation
        end
      end
      return nil
    end

    #given an array [year,month,day], it returns all the reservations on that day.
    #if there are no reservations on that day, returns an empty array
    def find_reservations_by_date(date)
      reservations_on_date = []
      @all_reservations.each do |reservation|
        if reservation.nights_booked.nights.include?(date)
          reservations_on_date << reservation
        end
      end
      return reservations_on_date
    end


  end
end

#
