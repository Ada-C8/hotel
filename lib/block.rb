module Hotel
  class Block
    # @rooms
    # @dates
    # @discount_rate
    def initialize(start_date, end_date, rooms, discount_rate)
      @start_date = start_date
      @end_date = end_date
      @dates = DateRange.range_to(@start_date, @end_date)
      @rooms = rooms
      @discount_rate = (100 - discount_rate) / 100
    end
  end
end
