# Logic for reservations here, aka reservation dates.
# I need this to require the date gem.
# This must initialize check in and check out dates
# This must also take those dates and use a method to calculate charges.
# I need to make sure that I can access this information in the hotel class which is going to hold all of the biz logic.

require 'date'
require 'rooms'

module HotelHedwig
  class Reservations

    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = check_in
      @check_out = check_out

      # Raise an argument error IF the check-in date is after the check-out date! Method?

      def invalid_date
        if @check_in < @check_out
          raise ArgumentError.new "Invalid date selection, please check and change your check-in and check-out dates."
        end
      end
    end
  end
end
