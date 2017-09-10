
module Reservable
  #Errors
  class DateError < StandardError
  end

  class PositiveIntegerError < StandardError
  end

  class UnavailableError < StandardError
  end

  class RoomLimit < StandardError
  end

  #Error checking
  def valid_date?(date)
    unless date.kind_of? Date
      raise DateError.new("Invalid Date! You submitted #{date}, which is not a Date object.")
    end
  end # valid_date? method
  #TODO CLI rescue

  def positive_integer?(num)
    unless (num.kind_of? Integer) && num > 0
      raise PositiveIntegerError.new("Invalid number! You submitted #{num}, which is not a positive integer.") #TODO CLI: rescue
    end
  end # positive_integer? method
  #TODO CLI rescue
  
  #Useful methods
  def date_range(start, nights)
    array = Array.new
    nights.times {|i| array << start + i}
    return array
  end

end # Reservable module
