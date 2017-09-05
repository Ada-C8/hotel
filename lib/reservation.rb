require 'date'
require_relative 'room'

module Hotel

  class Reservation
    attr_accessor :check_in, :check_out, :room_num

    def initialize(check_in, check_out, room_num)

      # check input
      raise ArgumentError.new("Check out must be later than check in") if check_in >= check_out

      @check_in = check_in
      @check_out = check_out
      @room_num = room_num

    end


  end # end of Reservation class
end
