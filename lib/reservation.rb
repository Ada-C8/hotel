module Hotel
  class Reservation
    require_relative 'date_range'
    attr_reader :total_cost, :dates, :checkin, :checkout, :id, :hotel, :room

    def initialize(room, checkin, checkout, hotel, block = false)
      @room = room
      @checkin = Date.parse(checkin)
      @checkout = Date.parse(checkout)
      @dates = DateRange.range_to(@checkin, @checkout)
      @id = create_id
      @block =
      get_total
    end

    def get_total
      num_nights = @dates.length
      @total_cost = @room.cost * num_nights
    end

    def includes_dates?(checkfirst, checklast)
      DateRange.overlap?(checkfirst, checklast, @checkin, @checkout)
    end

    private

    def create_id
      format('R%.2d%.2d%.4d', @checkin.month, @checkin.day, rand(9999))
    end
  end
end
