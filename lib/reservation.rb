require 'pry'

module Hotel
  class Reservation
    require_relative 'date_range'
    attr_reader :total_cost, :dates, :checkin, :checkout, :id, :hotel, :room, :block

    def initialize(room, checkin, checkout, hotel, block = false)
      @room = room
      @checkin = DateRange.validate(checkin)
      @checkout = DateRange.validate(checkout)
      @dates = DateRange.range_to(@checkin, @checkout)
      if block
        @block = hotel.block(block)
        raise(DatesError) unless @block.includes_all_dates?(checkin, checkout)
      else
        @block = false
      end
      get_total
    end

    def get_total
      num_nights = @dates.length
      @total_cost = @room.rate * num_nights
      @total_cost *= @block.discount_rate if @block
    end

    def includes_dates?(checkfirst, checklast)
      DateRange.overlap?(checkfirst, checklast, @checkin, @checkout)
    end
  end
end
