require 'date'
require 'awesome_print'
require 'pry'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out, :number_of_nights
    def initialize(check_in, check_out)
        @check_in = Date.parse(check_in)
        @check_out = Date.parse(check_out)
        @number_of_nights = (@check_out - @check_in).to_i
        unless @check_in > Date.today
          raise ArgumentError.new("That date has passed.")
        end
        unless @check_in < @check_out
          raise ArgumentError.new("Check in date must be before Check out date.")
        end
    end # end of initialize

    def overlap?(start_date, end_date)
      # comparing one instance of date to another
      # start_date = Date.parse(start_date)
      # end_date = Date.parse(start_date)

      if (self.check_in < Date.parse(end_date)) && (self.check_out >= Date.parse(start_date))
        return true
      else
        return false
      end
    end
    
    def return_date_range
      date_range = "#{@check_in} to #{@check_out}"
      # Hotel::HotelClass.reservations << date_range
      puts date_range
      return date_range
    end # end of return_date_range
  end # end of DateRange Clas
end # end of Module
