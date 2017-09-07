require 'Booking'
require 'DateRange'

module Hotel
  class Reservations
    attr_reader

    def initialize
    @all_reservations = []

    #(1..20).to_a
    #@rooms_collection = []
    # @blocks_arr = []
    end

    def all_rooms
      @rooms_collection = []
      n = 1

      (1..20).each do
        room = Hotel::Room.new(n)
        @rooms_collection << room
        n += 1
      end
      return @rooms_collection
    end

    def all_reservations
      return @all_reservations
    end

    # def self.all_blocks
    #   @blocks_collection = []
    # end

    def new_reservation(check_in, check_out, room_number = rand(1..20), room_rate = 200)
      booking = Hotel::Booking.new(check_in, check_out, room_number, room_rate)
      @all_reservations << booking
      return booking
    end

    def list_reservations_by_date(date)
      date = Date.parse(date)
      list = []
      @all_reservations.each do |reservation|
          #dates = reservation.dates
          # if reservation.dates.include?(date)
          #   list << reservation
          if date >= reservation.check_in && date <= reservation.check_out
            list << reservation
          end
      end
      return list
    end

    def clear_reservations #Using this for testing purposes
      @all_reservations = []
    end

  end
end
