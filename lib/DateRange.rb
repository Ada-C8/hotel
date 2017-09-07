require 'date'

module Hotel
  class DateRange
    def initialize(check_in, check_out)
      @check_in = check_in
      @check_out = check_out
      #@dates = []
    end

    def dates
    dates = (@check_in..@check_out).map(&:to_s)
      dates.each do |date|
        date = Date.parse(date)
      end
    return dates
    end
  end
end
