module Hotel
  class Block
    attr_reader :rooms

    def initialize(start_date, end_date, rooms, discount_rate)
      @start_date = start_date
      @end_date = end_date
      @dates = DateRange.range_to(@start_date, @end_date)
      @rooms = rooms
      @discount_rate = (100 - discount_rate) / 100
      @id = create_id
    end

    def create_id
      format('B%.2d%.2d%.4d', @start_date.month, @start_date.day, rand(9999))
    end
  end
end
