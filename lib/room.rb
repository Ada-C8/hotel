require_relative 'reservation'

module Hotel

  # NUM_ROOMS = 20

  class Room
    include Comparable

    DEFAULT_RATE = 200

    attr_reader :room_num, :reservations, :blocks
    attr_accessor :rate

    def initialize(room_num, rate = DEFAULT_RATE)

      raise ArgumentError.new("Not a valid room number") if room_num < 1

      @room_num = room_num
      @reservations = []
      @blocks = []
      @rate = rate

    end

    def <=>(other_room)
      room_num <=> other_room.room_num
    end

    def reserve(start_date, end_date)

      raise ArgumentError.new("Room #{room_num} isn't available for the given dates") if is_booked?(start_date, end_date)

      new_reservation = ::Hotel::Reservation.new(start_date, end_date, self)
      reservations << new_reservation

      return new_reservation

    end

    def is_booked?(start_date, end_date = start_date.next_day)

      return array_include_date?(reservations, start_date, end_date)

    end

    def is_blocked?(start_date, end_date = start_date.next_day)

      return array_include_date?(blocks, start_date, end_date)

    end

    def to_s
      # return human readable representation
      s = "Room number: #{room_num}\n"
      s += "Rate per night: $#{rate}\n"
      s += "Reservations:\n"

      reservations.each do |reservation|
        s += reservation.to_s
      end

      s += "Blocks:\n"
      blocks.each do |block|
        s += block.to_s
      end

      return (s += "\n")

    end

    private

    def array_include_date?(array, start_date, end_date)
      # don't include final date since check-out doesn't conflict with check-in of a new reservation
      date_range = (start_date...end_date).to_a

      array.each do |item|
        date_range.each do |date|
          if item.include?(date)
            return true
          end
        end
      end

      return false
    end

  end # end of Room class

end
