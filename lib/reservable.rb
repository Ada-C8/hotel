require 'date'

module Reservable

  def valid_dates?
    raise ArgumentError.new("Check out must be later than check in") if @check_in >= @check_out
  end

  def total_cost(rate = @rate)
    num_nights = (@check_out - @check_in).to_i
    return (num_nights * rate)
  end

  def include?(date)
    return date >= @check_in && date < @check_out
  end

end
