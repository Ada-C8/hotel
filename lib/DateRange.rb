require 'date'

module Hotel
  class DateRange
    def initialize(check_in, check_out)
      @check_in = check_in
      @check_out = check_out
      #@dates = []
    end

    def dates
    return Array(@check_in..@check_out)
      # dates.each do |date|
      #   date = Date.parse(date)
      # end
  
    end
  end
end
