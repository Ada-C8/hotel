module BookingSystem

  class DateRange

    def initialize(check_in, check_out)
      @check_in = Date.strptime(check_in, '%d-%m-%Y')
      @check_out = Date.strptime(check_out, '%d-%m-%Y')
    end #end of initialize

    def populate_dates

    end #end of method


  end #end of class

end #end of module
