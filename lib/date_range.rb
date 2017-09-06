require 'date'
module My_Hotel
  class Date_Range

    attr_reader :start_date, :end_date, :date_range

    def initialize(start_date, end_date)
      @start_date = Date.civil(start_date[0], start_date[1], start_date[2])
      @end_date = Date.civil(end_date[0], end_date[1], end_date[2])
      @date_range = [@start_date, @end_date]
    end



    # def valid_dates?
  # end
    #
    # def overlab?
    #   #is the start_date before the end_date?
    # end
    #


  end
end
