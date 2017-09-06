require 'date'

class DateRange
  attr_reader :nights, :start, :end
  def initialize(check_in, check_out)
    @start = check_in
    @end = check_out

    if @end <= @start
      raise ArgumentError.new("This is an invalid check-in/check-out combination")
    end

    @nights = (check_out-check_in)
    # @dates = alldays
  end
  #
  # def include?
  #
  # end
  #
  # def overlap?
  #
  # end

end
