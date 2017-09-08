require 'date'
require 'errors'
# require 'pry'

module Hotel
  class DateRange
    attr_reader :beginning, :ending, :number_days

    def initialize(date1, date2=nil)
      @beginning = date1
      @ending = date2
      one_day?
      is_valid?
      # binding.pry
    end

    def is_valid?
      # binding.pry
      if @beginning < Date.today #or @ending < Date.today
        raise DateError.new("You are living in the past, bud")
      end
      unless one_day?
        if @beginning > @ending
          raise DateError.new("Last night must be after first night")
        end
      end
    end

    def one_day?
      if @ending == nil
        return true
      else
        return false
      end
    end

    def number_days
      if one_day?
        @number_days = 1
      else
        @number_days = (@ending-@beginning).to_i + 1
      end
    end


    def include?(date)
      if one_day? && date == @beginning
        return true
      elsif one_day? && date != @beginning
        return false
      elsif @beginning <= date && date <= @ending
        return true
      else
        return false
      end
    end


#REFACTOR??
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
