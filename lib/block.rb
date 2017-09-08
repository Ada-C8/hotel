module Hotel
  class Block
    attr_reader :rooms, :id, :start_date, :end_date, :dates

    def initialize(start_date, end_date, rooms, discount_rate)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @dates = DateRange.range_to(@start_date, @end_date)
      @rooms = rooms
      @discount_rate = (100 - discount_rate) / 100
      @id = create_id
    end

    def create_id
      format('B%.2d%.2d%.4d', @start_date.month, @start_date.day, rand(9999))
    end

    def includes_dates?(checkfirst, checklast)
      DateRange.overlap?(checkfirst, checklast, @start_date, @end_date)
    end
  end
end
