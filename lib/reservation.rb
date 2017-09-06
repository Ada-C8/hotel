require 'date'
require_relative 'room'

module Hotel

  class Reservation
    include Comparable

    attr_accessor :check_in, :check_out, :room_num

    def initialize(check_in, check_out, room_num)

      # # check input move check input type != date to user interface
      # check_in = check_date(check_in)
      # check_out = check_date(check_out)
      #
      # raise ArgumentError.new("Invalid date(s)") if check_in == nil || check_out == nil

      raise ArgumentError.new("Check out must be later than check in") if check_in >= check_out

      @check_in = check_in
      @check_out = check_out
      @room_num = room_num

    end

    def ==(other_reservation)
      return check_in == other_reservation.check_in && check_out == other_reservation.check_out && room_num == other_reservation.room_num
    end

    def include?(date)
      return date >= check_in && date < check_out
    end

    # def self.find(date)
    #   # returns a list of all reservations for given date
    #   # does not include reservations where check-out date == date
    #
    # end

    def total_cost
      num_nights = (check_out - check_in).to_i
      return num_nights * ::Hotel::Room::DEFAULT_RATE
    end

    # private
    # move check_date to user interface
    # def check_date(date)
    #   if date.is_a?Date
    #     return date
    #   else
    #     begin date = Date.parse(date)
    #     rescue ArgumentError
    #       return nil
    #     rescue TypeError
    #       return nil
    #     else
    #       return date
    #     end
    #   end
    # end

  end # end of Reservation class
end
