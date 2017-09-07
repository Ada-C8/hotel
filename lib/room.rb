require_relative 'reservation'

module Hotel

  # NUM_ROOMS = 20

  class Room
    include Comparable

    DEFAULT_RATE = 200

    attr_reader :room_num, :reservations
    attr_accessor :rate

    def initialize(room_num, rate = DEFAULT_RATE)

      if room_num > 0
        @room_num = room_num
      else
        raise ArgumentError.new("Not a valid room number")
      end

      @reservations = []
      @rate = rate
    end

    def <=>(other_room)
      room_num <=> other_room.room_num
    end

    def reserve(start_date, end_date)
      # add reservation if room is available and return true; else false
      if !is_booked?(start_date, end_date)
        reservations << ::Hotel::Reservation.new(start_date, end_date, self) # replacing room_num with self
        return true
      end

      return false
    end

    def is_booked?(start_date, end_date = start_date.next_day)
      # don't include final date since check-out doesn't conflict with check-in of a new reservation
      date_range = (start_date...end_date).to_a

      reservations.each do |reservation|
        date_range.each do |date|
          if reservation.include?(date)
            return true
          end
        end
      end

      return false

    end

    private

    def to_s
      # return human readable representation
      s = "Room number: #{room_num}\n"
      s += "Rate per night: $#{rate}\n"
      s += "Reservations:\n"

      reservations.each do |reservation|
        s += reservation.to_s
      end

      return s

    end

    # def valid_room_num?(num)
    #   return num >= 1 && num <= ::Hotel::Hotel::NUM_ROOMS
    # end

    # def is_available?(start_date, end_date)
    #   @reservations.each do |reservation|
    #     check_in = reservation.check_in
    #     check_out = reservation.check_out
    #
    #     if date >= check_in && date < check_out
    #       return false
    #     end
    #   end
    #
    #   return true
    # end

  end # end of Room class

end
