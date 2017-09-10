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
      @block = block ? hotel.block(block) : false
      get_total
    end

    def get_total
      # puts "block is #{@block}"
      num_nights = @dates.length
      @total_cost = @room.cost * num_nights
      @total_cost *= @block.discount_rate if @block
      return @total_cost
    end

    def includes_dates?(checkfirst, checklast)
      DateRange.overlap?(checkfirst, checklast, @checkin, @checkout)
    end

    private

    # def create_id
    #   format('R%.2d%.2d%.4d', @checkin.month, @checkin.day, rand(9999))
    # end
  end
end
