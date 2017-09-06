require 'date'

module Hotel
  class DateRange
    attr_reader :date1, :date2, :number_days

    def initialize(date1, date2=nil)
      @date1 = date1
      @date2 = date2
      one_day?
      beginning
      ending
    end

    def one_day?
      if @date2 == nil
        return true
      else
        return false
      end
    end

    def beginning
      if !one_day? && @date1 < @date2
        @beginning = @date1
      elsif !one_day? && @date2 < @date1
        @beginning = @date2
      elsif one_day?
        @beginning = @date1
      end
    end

    def ending
      if !one_day? && @date1 > @date2
        @ending = @date1
      elsif !one_day? && @date2 > @date1
        @ending = @date2
      elsif one_day?
        @ending = @date1
      end
    end

    def number_days
        @number_days = (@ending-@beginning).to_i + 1
    end


    def include?(date)
      if (one_day? && date == @date1) || (@beginning <= date && date <= @ending)
        return true
      else
        return false
      end
    end

    def overlap?(daterange)
      if include?(daterange.beginning) || include?(daterange.ending)
        return true
      elsif daterange.include?(@beginning) || daterange.include?(@ending)
        return true
      else
        return false
      end
    end

  end
end
