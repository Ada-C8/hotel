require 'date'
require_relative 'room'

module BookingSystem
  class Reservation
    attr_reader :first_name, :last_name, :room_id, :room_rate, :reserv_id, :start_date, :end_date, :room_count, :total_cost

    def initialize(first_name, last_name, room_id, room_rate, reserv_id, start_date, end_date, room_count) #assuming dates are already entered as objects using Date.parse("DD/MM/YYYY")
      # raise ArgumentError.new("start_date must be a string in the format: DD/MM/YYYY") if !start_date
      @first_name = first_name
      @last_name = last_name
      @reserv_id = reserv_id #how am I going to generate a reserv_id?
      @start_date = start_date
      @end_date = end_date
      @room_id = room_id
      @room_rate = room_rate
      @room_count = room_count

      @total_cost = 0
    end

    def get_total_cost #(start_date, end_date, room_rate, room_count) would hotel use these as arguments to get total_cost?
      date_diff = @end_date - @start_date
      @total_cost = date_diff * (@room_rate * @room_count)
      return @total_cost
    end

  end#of_Reservation_class
end#of_module_BookingSystem
