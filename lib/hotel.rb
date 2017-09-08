require_relative 'reservation'
require_relative 'date_range'
require_relative 'no_room_available'
require_relative 'block'

module BookingSystem
  class Hotel

    DEFAULT_ROOMS = {1 => 150, 2 => 200, 3 => 350, 4 => 120, 5 => 150, 6 => 170, 7 => 180, 8 => 150, 9 => 190, 10 => 200, 11 => 220, 12 => 135, 13 => 200, 14 => 190, 15 => 220, 16 => 200, 17 => 220, 18 => 250, 19 => 200, 20 => 250}

    DEFAULT_DISCOUNT = 10

    attr_reader :rooms, :all_reservations, :block_discount, :all_blocks

    def initialize(rooms=DEFAULT_ROOMS, block_discount=DEFAULT_DISCOUNT)
      @all_reservations = [] #array of instances of class Reservation
      @all_blocks = [] #array of instances of class Block
      @rooms = rooms
      @block_discount = block_discount

    end #end of initialize

    def room_unavailable(room)
      dates = []
      @all_reservations.each do |reservation|
        if reservation.room == room
          reservation.date_range.dates_within_range.each do |date|
            dates << date
          end
        end
      end
      puts dates
      @all_blocks.each do |block|
        block.rooms.each do |block_room, price|
          if block_room == room
            block.date_range.dates_within_range.each do |date|
              dates << date
            end
          end
        end
      end
      puts dates
      return dates #array of dates on which this room is unavailable
      end #end of method

    def list_of_available_rooms(date_range)
      available_rooms = {}
      @rooms.each do |room, price|
        booked_dates = room_unavailable(room) #array of dates
        puts "booked dates: #{booked_dates} for room: #{room}"
        count = 0
        date_range.dates_within_range.each do |date|
          if !booked_dates.include?(date)
            count += 1
            puts "#{count} after each new date"
          end
        end
        puts "final count: #{count}"
        puts "number of nights: #{date_range.dates_within_range.length}"
        if count == date_range.dates_within_range.length
          available_rooms[room] = price
        end
      end
      puts available_rooms
      return available_rooms #hash of rooms
    end #end of method

    def find_room(date_range)
      if list_of_available_rooms(date_range).empty?
        raise NoRoomAvailableError.new("No room is available on given dates")
      end
      return list_of_available_rooms(date_range).first[0] #room number
    end #end of method

    #picks the first available room
    def make_reservation(date_range)
      room = find_room(date_range)
      cost = @rooms[room]
      new_reservation = Reservation.new(date_range, room, cost)
      @all_reservations << new_reservation

      return new_reservation #new instance of class Reservation
    end #end of method

    def list_of_reservations(date)
      list = @all_reservations.map { |reservation| reservation if reservation.date_range.dates_within_range.include?(date) }

      return list #array of reservations
    end #end of method

    def create_block(date_range, number_of_rooms)
      if number_of_rooms > 5
        number_of_rooms = 5
      end
      if list_of_available_rooms(date_range).length < number_of_rooms
        raise NoRoomAvailableError.new("Not enough available rooms on given dates")
      end
        block_rooms = Hash[list_of_available_rooms(date_range).sort_by { |k, v| k }[0..number_of_rooms-1]]
        new_block = Block.new(date_range, block_rooms)
        @all_blocks << new_block

      return new_block #has hash of rooms and prices
    end #end of method

    def make_reservation_from_block(block)
      if !block.has_available_rooms?
        raise NoRoomAvailableError.new("No room is available on given dates")
      end
      date_range = block.date_range
      room = block.rooms.first[0]
      cost = @rooms[room] * (1 - @block_discount / 100.0)
      new_reservation_from_block = Reservation.new(date_range, room, cost)
      block.rooms.delete(room)
      return new_reservation_from_block #instance of class Block

    end #end of method

    # def reset_hotel
    #   @all_reservations = []
    #   @all_blocks = []
    # end #end of method


  end #end of class

end #end of module
