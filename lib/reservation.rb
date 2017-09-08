require 'securerandom'

module Hotel
  class Reservation
    attr_reader :check_in, :check_out, :room

    def initialize(check_in, check_out, room)
      @check_in = check_in
      @check_out = check_out
      @room = room
      @room.change_availability(false) # Sets availability to false
    end

    def to_s
      puts "Reservation: "
      puts "  Check-in: #{check_in}"
      puts "  Check-out: #{check_out}"
      puts "  Room: ##{room.room_number}"
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
