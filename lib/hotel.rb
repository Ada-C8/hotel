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
      # TODO check if available and return true if added; else false

      room.reserve(start_date, end_date)

    end

    # def all_reservations # is this necessary??
    #   # returns a list of all reservations for the hotel
    #   reservations = []
    #
    #   rooms.each do |room|
    #     reservations.concat(room.reservations)
    #   end
    #
    #   return reservations
    # end

    def find_reservations_by_date(date)
      # returns a list of all reservations for the given date
      # doesn't include rooms where check-out date == date
      reservations = []

      rooms.each do |room_num, room|
        reservations.concat(room.reservations.select { |reservation| reservation.include? date })
      end

      # organize using group_by? (room_num)
      return reservations

      # reservations = []
      #
      # all_reservations.each do |reservation|
      #
      #   # if date >= reservation.check_in && date < reservation.check_out
      #   #   reservations << reservation
      #   # end
      #   if reservation.include?(date)
      #     reservations << reservation
      #   end
      # end
      #
      # return reservations
    end

    def find_avail_rooms(start_date, end_date)
      # returns a list of rooms available in the date range
      avail_rooms = (1..rooms.length).to_a
      date_range = (start_date...end_date).to_a  # don't include end date since checkout won't conflict with start date of another res

      # iterate through all room numbers and check if room reservations include any of the dates in date range
      (1..avail_rooms.length).each do |room_num|
        room = rooms[room_num]

        date_range.each do |date|
          room.reservations.each do |reservation|
            puts "iterating through reservations for room #{room_num}"

            if reservation.include?(date)
              avail_rooms.delete(room_num)
              puts "breaking out...or am I?"
              break
            end
          end
        end
      end

      # return list of room objects
      return avail_rooms.map { |room_num| rooms[room_num] }

    end

    # private
    #
    # def is_valid?(num) move integer check to user input
    #   return num.is_a?(Integer) && num > 0
    # end

  end # end of Hotel class

end
