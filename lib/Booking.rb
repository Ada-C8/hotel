require 'date'
require 'DateRange'

module Hotel
  class Booking
    # include DateRange
    attr_reader :check_in, :check_out, :room_number, :total_cost
    def initialize(check_in, check_out, room_number = rand(1..20), room_rate = 200) #total_cost = 200)
      @room_number = room_number
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @date_range = DateRange.new(@check_in, @check_out)
      @dates = @date_range.dates
      @room_rate = room_rate
      #@dates = Hotel::DateRange.new(check_in, check_out)
      # @num_days = (@check_out - @check_in).to_i
      # @total_cost = (@room_rate * @num_days)
      @discount = 0
    end

    def dates
    dates = (@check_in..@check_out).map(&:to_s)
      dates.each do |date|
        date = Date.parse(date)
      end
    return dates
    end

    def total_cost
      num_days = (@check_out - @check_in).to_i
      total_cost = @room_rate * num_days
      return total_cost
    end
  end

end
