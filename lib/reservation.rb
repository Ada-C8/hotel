module Hotel
  class Reservation
    attr_reader :check_in, :check_out, :room

    def initialize(check_in, check_out, room)
      raise InvalidObjectPassedError.new() if check_in.class != Date || check_out.class != Date
      raise DateRangeInvalidError.new() if check_out <= check_in

      @check_in = check_in
      @check_out = check_out
      @room = room
    end

    # def to_s
    #   puts "Reservation: "
    #   puts "  Check-in: #{check_in}"
    #   puts "  Check-out: #{check_out}"
    #   puts "  Room: ##{room.room_number}"
    # end

    # As an administrator, I can get the total cost for a given reservation
    def total_cost
      total_days = (check_out - check_in).to_i
      return room.cost * total_days
    end

    # (check_in >= reservation.check_in || check_out < reservation.check_out) && room_num == reservation.room.room_number
    def overlap?(other_check_in, other_check_out)
      # return (check_in >= other_check_in || check_out < other_check_out) &&
      #        room.room_number == other_room_num
      return (other_check_in == check_in ||
             (other_check_in < check_in && (other_check_out > check_in && other_check_out < check_out)) ||
             (other_check_in > check_in && other_check_in < check_out))
    end
  end
end
