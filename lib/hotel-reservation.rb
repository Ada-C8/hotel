require 'Date'
require_relative 'hotel-errors'
module Hotel
  class Reservation
    @@all_reservations = []
    @@block_rooms = {}

    attr_reader :start_date, :end_date, :room, :rate, :total_cost, :block

    def initialize(start_date, end_date, room, rate: 200)
      if end_date > start_date
        @start_date = start_date
        @end_date = end_date
      else
        raise DateError.new "End date is before start date"
      end
      if room.available?(start_date, end_date)
        @room = room
      else
        raise InvalidRoomError.new "Room is not available"
      end
      @number_of_nights = (@end_date - @start_date).to_i
      @total_cost = (rate * @number_of_nights)
      @rate = rate
      @@all_reservations << self
    end


    def self.list_for_date(date)
      list_of_reservations = []
      @@all_reservations.each do |reservation|
        if (reservation.start_date...reservation.end_date).include?(date)
          list_of_reservations << reservation
        end
      end
      return list_of_reservations
    end

    def self.blocklist_for_date(date)
      list_of_reservations = []
      @@block_rooms.each do |name,block|
        block.each do |reservation|
          if (reservation.start_date...reservation.end_date).include?(date)
            list_of_reservations << reservation
          end
        end
      end
      return list_of_reservations
    end

    def self.list_all
      return @@all_reservations
    end

    def self.block_rooms(start_date, end_date, number_of_rooms, rate, name)
      raise InvalidRoomError.new("Invalid number of rooms") if number_of_rooms > 5 || number_of_rooms < 1
      available_rooms = Hotel::Room.all_available_rooms(start_date, end_date)
      if number_of_rooms > available_rooms.length
        puts "We don't have enough available rooms"
        puts "We will now only block #{available_rooms.length}"
        number_of_rooms = available_rooms.length
      end
      block = []
      number_of_rooms.times do |i|
        block << self.new(start_date, end_date, available_rooms[i], rate: rate)
      end
      @@block_rooms[name] = block
      puts "You have blocked #{number_of_rooms} rooms for the rate of $#{rate} and for the dates of #{start_date} - #{end_date}, under the name of #{name}"
      return @@block_rooms
    end

    def self.reserve_block_room(block_name)
      if block_availability(block_name)
        array_of_rooms = @@block_rooms[block_name]
        @@all_reservations << array_of_rooms[0]
        puts "We have added your reservation"
        @@block_rooms[block_name].delete_at(0)
      else
        raise InvalidRoomError.new "No rooms available in this block"
      end
    end

    def self.block_availability(block_name)
      rooms = @@block_rooms[block_name]
      if rooms.nil?
        return false
      elsif rooms.length > 0
        return true
      else
        return false
      end
    end

    def to_s
      return "A reservation has been made for room ##{@room.number} during #{@start_date} - #{@end_date} with a rate of $#{@rate} for a total cost of $#{@total_cost}"
    end

  end
end
