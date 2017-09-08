require 'date'
require 'errors'
# require 'pry'

module Hotel
  class DateRange
    attr_reader :beginning, :ending, :number_days

    def initialize(date1, date2=nil)
      @beginning = date1
      @ending = date2
      is_valid?
    end

    def is_valid?
      # binding.pry
      raise DateError.new("You are living in the past, bud") if @beginning < Date.today
      unless one_day?
        raise DateError.new("Last night must be after first night") if @beginning > @ending
      end
    end

    def one_day?
      return true if @ending == nil
      return false
    end

    def number_days
      if one_day?
        @number_days = 1
      else
        @number_days = (@ending-@beginning).to_i + 1
      end
    end


    def include?(date)
      if one_day? && date != @beginning
        return false
      elsif (one_day? && date == @beginning) || (@beginning <= date && date <= @ending)
        return true
      else
        return false
      end
    end


    def overlap?(daterange)
      return true if include?(daterange.beginning) || include?(daterange.ending)
      return false
    end

  end
end
