require 'date'

module Hotel
class DateRange
  attr_reader :date1, :date2

  def initialize(date1, date2)
    @date1 = date1
    @date2 = date2
  end

  def one_day?
    if date1 == date2
      return true
    else
      return false
    end
  end

  def begin
    if !one_day? && date1 < date2
        @beginning = date1
      elsif !one_day? && date2 < date1
        @beginning = date2
      end
  end

  #def end
    #if !one_day? && date1 is after date2
      #@end = date1
    #elsif !one_day? && date2 is after date1
      #@end = date2
  #  end
    #end


  #
  # def include?
  # end
  #
  # def overlap?
  # end

end
end
