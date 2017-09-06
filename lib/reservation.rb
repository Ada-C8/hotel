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

    def self.find(date)
      # returns a list of all reservations for given date
      # does not include reservations where check-out date == date
    end

    def total_cost
      num_nights = (@check_out - @check_in).to_i
      return num_nights * ::Hotel::Room::DEFAULT_RATE
    end


  end # end of Reservation class
end
