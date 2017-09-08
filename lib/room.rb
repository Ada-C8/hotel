require_relative 'reservation'

module Hotel

  # NUM_ROOMS = 20

  class Room
    include Comparable

    DEFAULT_RATE = 200

    attr_reader :room_num, :reservations, :blocks
    attr_accessor :rate

    def initialize(room_num, rate = DEFAULT_RATE)

      if room_num > 0
        @room_num = room_num
      else
        raise ArgumentError.new("Not a valid room number")
      end

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

    def is_blocked?(start_date, end_date = start_date.next_day)
      date_range = (start_date...end_date).to_a

      blocks.each do |block|
        date_range.each do |date|
          if block.include?(date)
            return true
          end
        end
      end

      return false

    end

    #private

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
