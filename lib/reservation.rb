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

  end
end
