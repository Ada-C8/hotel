require_relative 'room'
require_relative 'reservation'

module Hotel

  class Hotel
    include Reservable

    NUM_ROOMS = 20

    attr_reader :rooms

    def initialize(num_rooms = NUM_ROOMS)
      # check input
      check_room_num(num_rooms)

      @rooms = {}

      # loop through num_rooms and add rooms to hash
      (1..num_rooms).each do |num|
        @rooms[num] = ::Hotel::Room.new(num)
      end

    end

    def reserve(start_date, end_date, room)
      check_dates(start_date, end_date)

      raise ArgumentError.new("Room #{room.room_num} isn't available for the selected dates") if room.booked?(start_date, end_date) || room.blocked?(start_date, end_date)

      return room.reserve(start_date, end_date)

    end

    def block(start_date, end_date, discount, rooms)
      raise ArgumentError.new("One or more rooms is unavailable for the selected dates") if rooms.any? { |room| room.booked?(start_date, end_date) || room.blocked?(start_date, end_date) }

      return Hotel::Block.new(start_date, end_date, discount, rooms)
    end

    def find_reservations_by_date(date)
      return ::Hotel::Reservation.find_by_date(date)
    end

    def find_avail_rooms(start_date, end_date)
      # returns a hash of rooms available in the date range

      # check input
      check_dates(start_date, end_date)

      return rooms.reject { |room_num, room| room.booked?(start_date, end_date) || room.blocked?(start_date, end_date) }

    end

  end # end of Hotel class

end
