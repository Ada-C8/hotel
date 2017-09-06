require 'date'
#OPTIONAL ARGUMENT??
module Hotel
  class DateRange
    attr_reader :date1, :date2, :number_days

    def initialize(date1, date2=nil)
      @date1 = date1
      @date2 = date2
      # @one_day = true
      one_day?
      #puts "one_day?: #{one_day?} class: #{one_day?.class}"
      beginning
      #puts "beginning: #{beginning} class: #{beginning.class}"
      ending
      #puts "ending: #{ending} class #{ending.class}"
    end

    def one_day?
      if @date1 == @date2
        return true
      else
        return false
      end
    end

    def beginning
      if @date1 <= @date2
        @beginning = @date1
      elsif @date2 <= @date1
        @beginning = @date2
      end
    end

    def ending
      if  @date1 >= @date2
        @ending = @date1
      elsif @date2 >= @date1
        @ending = @date2
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
