module My_Hotel
  class Date_Range

    attr_reader :date_range

    def initialize(start_date, end_date)
      @start_date = end_date
      @end_date = start_date
      @date_range = make_date_range
    end



    # def valid_dates?
  # end
    #
    # def overlab?
    #   #is the start_date before the end_date?
    # end
    #
    # def make_date_range
    #
    # end


  end
end
