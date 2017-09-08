#reservation
require 'date'


module HotelManagment
  class Reservation
    attr_reader :first_name, :last_name, :check_in_date, :check_out_date, :room_number, :cost


    def initialize(first_name, last_name, check_in_date, check_out_date, room_number)
      @first_name = first_name
      @last_name = last_name
      @check_in_date = check_in_date
      @check_out_date = check_out_date
      @room_number = room_number
      @cost = cost
    end

    def rate
      nights = @check_out_date - @check_in_date
      @cost = nights.to_i * Room::RATE
    end

  end #class end
end #module end
