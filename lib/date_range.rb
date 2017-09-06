require 'date'

class DateRange
  # attr_reader
  def initialize(check_in, check_out)
    @start = check_in
    @end = check_out
    if @end < @start
      raise ArgumentError.new("This is an invalid check-in/check-out combination")
    end
    # @dates = alldays
  end

  def include?

  end

  def overlap?

  end

end
