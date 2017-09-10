module Hotel
  class Block
    attr_reader :rooms, :id, :start_date, :end_date, :dates, :discount_rate

    def initialize(start_date, end_date, rooms, discount_rate)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @dates = DateRange.range_to(@start_date, @end_date)
      @rooms = rooms
      @discount_rate = get_discount_rate(discount_rate)
      @id = create_id
    end

    def create_id
      format('B%.2d%.2d%.4d', @start_date.month, @start_date.day, rand(9999))
    end

    def includes_dates?(checkfirst, checklast)
      DateRange.overlap?(checkfirst, checklast, @start_date, @end_date)
    end

    def includes_all_dates?(checkfirst, checklast)
      DateRange.include_all?(checkfirst, checklast, @start_date, @end_date)
    end

    def get_discount_rate(input)
      raise(ArgumentError, "Discount must be number: was #{input.class}") unless input.class == (Integer || Float)
      raise(DiscountError, "Discount must be between 0-100%: was #{input}") unless 0 <= input && input <= 100
      return (100.0 - input) / 100
    end
  end
end
