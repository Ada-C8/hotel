require 'date'
require_relative 'room'
require_relative 'reservable'

module Hotel

  class Reservation
    include Comparable
    include Reservable

    attr_accessor :check_in, :check_out, :room_num, :rate

    def initialize(check_in, check_out, room)

      # # check input move check input type != date to user interface
      # check_in = check_date(check_in)
      # check_out = check_date(check_out)
      #
      # raise ArgumentError.new("Invalid date(s)") if check_in == nil || check_out == nil

      # raise ArgumentError.new("Check out must be later than check in") if check_in >= check_out
      # @reservation_id = rand(100000..999999)
      @check_in = check_in
      @check_out = check_out
      @room_num = room.room_num
      @rate = room.rate

      valid_dates?

    end

    def ==(other_reservation)
      return check_in == other_reservation.check_in && check_out == other_reservation.check_out && room_num == other_reservation.room_num
    end

    # def include?(date)
    #   return date >= check_in && date < check_out
    # end

    # def total_cost
    #   num_nights = (check_out - check_in).to_i
    #   # return num_nights * ::Hotel::Room::DEFAULT_RATE
    #   return num_nights * rate
    # end

    #private

    def to_s
      # return human readable representation
      s = "Reservation id: #{reservation_id}\n"
      s += "Room number: #{room_num}\n"
      s += "Check-in: #{check_in}\n"
      s += "Check-out: #{check_out}\n"

      return s

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
