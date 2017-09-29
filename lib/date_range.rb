
module Hotel
  class DateRange

  attr_reader :total_nights, :check_in, :check_out

  def initialize(check_in, check_out)
    @check_in = check_valid_date(check_in)
    @check_out = check_valid_date(check_out)
    @total_nights = calculate_length
  end

  def include_date?(date)
    date.between?(@check_in, @check_out - 1)
  end

  def calculate_length
    if @check_in >= @check_out || @check_in < Date.today
      raise ArgumentError.new "invalid dates"
    else
      length = @check_out - @check_in
      return length.to_i
    end
  end

  def check_valid_date(date)
    if date.is_a? (Date)
      return date
    else
      raise ArgumentError.new "argument must be a Date. Current argument is #{date.class}"
    end
  end

  def overlap(other_res)
    overlap = (@check_in...@check_out).to_a & (other_res.check_in...other_res.check_out).to_a
    return overlap
  end






  end #end DateRange
end #end Hotel
