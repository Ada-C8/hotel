require_relative 'reservation'
require_relative 'date_range'
require_relative 'no_room_available'
require_relative 'block'

module BookingSystem
  class Hotel

    # COST = 200
    # BLOCK_DISCOUNT = 10

    attr_reader :rooms, :all_reservations, :cost, :block_discount

    def initialize(number_of_rooms, cost=200, block_discount=10)
      @rooms = (1 .. number_of_rooms).to_a
      @all_reservations = [] #array of instances of class Reservation
      @all_blocks = [] #array of instances of class Block
      @cost = cost
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
      @all_blocks.each do |block|
        block.rooms.each do |block_room|
          if block_room == room
            block.date_range.dates_within_range.each do |date|
              dates << date
            end
          end
        end
      end
      return dates.uniq #array of dates on which this room is unavailable
      end #end of method

    def list_of_available_rooms(date_range)
      available_rooms = []
      @rooms.each_with_index do |room, i|
        booked_dates = room_unavailable(i + 1) #array of dates

        count = 0
        date_range.dates_within_range.each do |date|
          if !booked_dates.include?(date)
            count += 1
          end
        end
        if count == date_range.dates_within_range.length
          available_rooms << room
        end
      end
      return available_rooms #array of rooms as integers
    end #end of method

    def find_room(date_range)
      return list_of_available_rooms(date_range)[0] #room number
    end #end of method

    def make_reservation(date_range) # strategy = :cheapest
      room = find_room(date_range)
      if room == nil
        raise NoRoomAvailableError.new("No room is available on given dates")
      end
      cost = @cost
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
        raise NoRoomAvailableError.new("No room is available on given dates")
      end
        block_rooms = list_of_available_rooms(date_range)[0..number_of_rooms-1]
        new_block = Block.new(date_range, block_rooms)
        @all_blocks << new_block

      return new_block #array of rooms as integers
    end #end of method

    def make_reservation_from_block(block)
      if !block.has_available_rooms?
        raise NoRoomAvailableError.new("No room is available on given dates")
      end
      date_range = block.date_range
      room = block.rooms[0]
      cost = @cost * (1 - @block_discount / 100.0)
      puts cost
      new_reservation_from_block = Reservation.new(date_range, room, cost)
      block.rooms.delete_at(0)
      return new_reservation_from_block #instance of class Block

    end #end of method


  end #end of class

end #end of module
