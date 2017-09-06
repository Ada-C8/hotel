require 'Date'
require 'Awesome_Print'

module Hotel
  class Reservation
    @@all_reservations = []
    @@block_rooms = []

    attr_reader :start_date, :end_date, :room, :rate, :total_cost, :block

    def initialize(start_date, end_date, room, rate: 200, block: nil)
      if check_date(start_date, end_date)
        @start_date = start_date
        @end_date = end_date
      end
      #move to script! Date.valid_date?()
      # puts room.available?(start_date, end_date)
      if room.available?(start_date, end_date)
        @room = room
      else
        raise ArgumentError.new "Room is not available"
      end
      @number_of_nights = (@end_date - @start_date).to_i
      @total_cost = (rate * @number_of_nights).round(2)
      @block = block
      @rate = rate
      @@all_reservations << self
    end

    def check_date(start_date, end_date)
      if end_date > start_date
        return true
      else
        raise ArgumentError.new "End date is before start date"
      end
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

    def self.list_all
      return @@all_reservations
    end

    def self.block_rooms(start_date, end_date, number_of_rooms, rate, name)
      raise ArgumentError.new("Max # of rooms is 5") if number_of_rooms > 5
      # self.check_date(start_date, end_date)
      available_rooms = Hotel::Room.all_available_rooms(start_date, end_date)
      if number_of_rooms > available_rooms.length
        puts "We don't have enough avaialbe rooms"
        puts "We will now only block #{available_rooms.length}"
        number_of_rooms = available_rooms.length
      end
      number_of_rooms.times do |i|
        @@block_rooms << self.new(start_date, end_date, available_rooms[i], rate: rate, block: name)
      end
      puts "You have blocked #{number_of_rooms} rooms for the rate of $#{rate} and for the dates of #{start_date}-#{end_date}, under the name of #{name}"
      return @@block_rooms
    end

  end
end
