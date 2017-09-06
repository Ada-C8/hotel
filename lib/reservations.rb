require 'date'
require_relative 'hotel.rb'
require_relative 'room.rb'


module Hotel_System

  class Reservations
    attr_accessor :all_rooms, :check_in, :check_out, :res_room_number, :hotel, :today, :num_of_nights, :all_reservations, :total_cost

    def initialize(room_number, check_in, check_out, parent_hotel = Hotel_System::Hotel.new )
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @hotel = parent_hotel
      @res_room_number = @hotel.return_room_object_by_num(room_number).room_number
      @today = Date.today
      @hotel.all_reservations << self
    end

    def avail?

    end

    def valid_date_range?
      if check_in < today
        raise ArgumentError.new("Invalid check in date")
      elsif check_out < today
        raise ArgumentError.new("Invalid check out date")
      elsif check_out < check_in
        raise ArgumentError.new("Invalid date range")
      elsif check_in == check_out
        raise ArgumentError.new("Check out must be after check in")
      else
        return true
      end
    end

    def num_of_nights
      @num_of_nights = (@check_out - @check_in).to_i
    end

    def total_cost
    total_cost = num_of_nights * @hotel.return_room_object_by_num(res_room_number).price
    end
  end

end
