require_relative 'room'
require_relative 'reservation'

module Hotel

  class Hotel

    NUM_ROOMS = 20

    attr_reader :rooms

    def initialize(num_rooms = NUM_ROOMS)
      # check input
      raise ArgumentError.new("Not a valid number of rooms") if !is_valid?(num_rooms)

      @rooms = []

      # loop through num_rooms and add rooms to array
      (1..num_rooms).each do |num|
        @rooms << ::Hotel::Room.new(num)
      end

    end

    def reserve(start_date, end_date, room)
      # TODO check if available and return true if added; else false

      room.reserve(start_date, end_date)

    end

    def all_reservations
      # returns a list of all reservations for the hotel
      reservations = []

      @rooms.each do |room|
        reservations << room.reservations
      end

      return reservations
    end

    def find_reservations_by_date(date)
      # returns a list of all reservations for the given date
      # doesn't include rooms where check-out date == date
    end

    private

    def is_valid?(num)
      return num.is_a?(Integer) && num > 0
    end

  end # end of Hotel class

end
