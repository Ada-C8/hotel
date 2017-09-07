require 'securerandom'

module Hotel
  class Reservation
    attr_reader :check_in, :check_out, :room

    def initialize(check_in, check_out, room)
      @check_in = check_in
      @check_out = check_out
      @room = room
      @room.change_availability
    end

    def to_s
      puts "Reservation: "
      puts "  Check-in: #{check_in}"
      puts "  Check-out: #{check_out}"
      puts "  Room: ##{room.room_number}"
    end

  end
end
