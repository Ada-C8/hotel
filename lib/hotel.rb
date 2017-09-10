require_relative 'room'
require_relative 'reservation'

module Hotel

  class Hotel

    NUM_ROOMS = 20

    attr_reader :rooms

    def initialize(num_rooms = NUM_ROOMS)
      # check input
      raise ArgumentError.new("Not a valid number of rooms") if num_rooms < 1

      @rooms = {}

      # loop through num_rooms and add rooms to hash
      (1..num_rooms).each do |num|
        @rooms[num] = ::Hotel::Room.new(num)
      end

    end

    def reserve(start_date, end_date, room)
      raise ArgumentError.new("Room #{room.room_num} isn't available for the selected dates") if room.unavailable?(start_date, end_date)

      return room.reserve(start_date, end_date)

    end

    def block(start_date, end_date, discount, rooms)
      raise ArgumentError.new("One or more rooms is unavailable for the selected dates") if rooms.any? { |room| room.unavailable?(start_date, end_date) }

      return Hotel::Block.new(start_date, end_date, discount, rooms)
    end

    def find_reservations_by_date(date)
      # returns a list of all reservations for the given date
      # doesn't include rooms where check-out date == date
      reservations = []

      rooms.each do |room_num, room|
        reservations.concat(room.reservations.select { |reservation| reservation.include? date })
      end

      # organize using group_by? (room_num)
      return reservations

    end

    def find_avail_rooms(start_date, end_date)
      # returns a hash of rooms available in the date range

      # check input
      raise ArgumentError.new("End date must be after start date") if start_date >= end_date

      return rooms.reject { |room_num, room| room.booked?(start_date, end_date) || room.blocked?(start_date, end_date) }

    end

  end # end of Hotel class

end
