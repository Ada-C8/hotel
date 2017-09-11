require 'date'
require 'date_range'

module BookingSystem
  class Reservation
    attr_reader :first_name, :last_name, :room_id, :room_rate, :start_date, :end_date, :total_cost, :date_range

    def initialize(first_name, last_name, room_id, room_rate, start_date, end_date)
      @first_name = first_name
      @last_name = last_name

      @room_id = room_id
      @room_rate = room_rate

      raise InvalidDateError.new("Start date is not a valid date object") if !start_date.is_a? Date
      @start_date = start_date

      raise InvalidDateError.new("End date is not a valid date object") if !end_date.is_a? Date
      @end_date = end_date

      @date_range = get_date_range
      @total_cost = get_total_cost
    end

    def get_total_cost
      date_diff = @end_date - @start_date
      grand_total = date_diff * @room_rate
      return grand_total
    end

    def get_date_range
      raise InvalidDateRangeError.new("Invalid date range") if @end_date <= @start_date #if end_date is older or equal to start_date, raise error
      range = DateRange.new(@start_date, @end_date)
      return range
    end

  end#of_Reservation_class
end#of_module_BookingSystem











=begin
NOTES:
#DATE RANGE METHOD (VERSION1)
# def make_date_range_array
#   return (@start_date .. @end_date).map{|day| day}
# end
#Modify: @date_range = make_date_range_array

#OUTPUTS: an array of the date range
=end
