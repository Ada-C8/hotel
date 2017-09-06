require 'date'
require_relative 'hotel.rb'
require_relative 'room.rb'


module Hotel_System


  class Reservations
    attr_accessor :all_rooms, :check_in, :check_out, :res_room_number, :today

    @today = Date.today
    puts @today

    def initialize(room_num, check_in, check_out)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @res_room_number = room_num
    end

    def avail?

    end

    def valid_date_range?
      if @check_in < @today
        raise ArgumentError.new("Invalid check in date")
      elsif @check_out < @today
        raise ArgumentError.new("Invalid check out date")
      elsif @check_out < @check_in
        raise ArgumentError.new("Invalid date range")
      elsif @check_in == @check_out
        raise ArgumentError.new("Check out must be after check in")
      else
        return true
      end
    end

  end

end
