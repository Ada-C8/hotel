require 'date'
require_relative 'room'

module BookingSystem
  class Reservation
    attr_reader :first_name, :last_name, :room_id, :room_rate, :start_date, :end_date, :total_cost, :date_range

    def initialize(first_name, last_name, room_id, room_rate, start_date, end_date) #assuming dates are already entered as objects using Date.parse("DD/MM/YYYY")

      @first_name = first_name
      @last_name = last_name

      @room_id = room_id
      @room_rate = room_rate

      @start_date = start_date
      @end_date = end_date
      @date_range = make_date_range_array
      @total_cost = get_total_cost #returns grand_total, the result of get_total_cost
    end

    def get_total_cost #(start_date, end_date, room_rate, room_count) would hotel use these as arguments to get total_cost?
      date_diff = @end_date - @start_date
      grand_total = date_diff * @room_rate
      return grand_total
    end

    def make_date_range_array
      return (@start_date .. @end_date).map{|day| day}
    end


  end#of_Reservation_class
end#of_module_BookingSystem
