module Hotel

  class DateRange

    attr_reader :check_in, :check_out

    def initialize(year_1, month_1, date_1, year_2, month_2, date_2)
      @check_in = Date.new(year_1, month_1, date_1)
      @check_out = Date.new(year_2, month_2, date_2)
    end



  end #class

end #hotel
