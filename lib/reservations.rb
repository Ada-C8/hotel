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

      # Raise an argument error IF the check-in date is after the check-out date!

      # Argument error conditional? How to do this 'before'.
      # Pseudocode;
      # if @check_in before @check_out
      #   raise ArgumentError "Invalid date selection, please check and change your check-in and check-out dates."
      # end

      # Calculating costs take 3, not sure how to best calculate this or if it belongs here.  The idea is using the base amount aka room_cost (200) multiplied by the number of days customer stays.  Check out day minus check in day provides that number.  I hope. This should also allow for a one day stay ex. 200 * (day 2 - day 1) = 200 * 1 = 200.

      def charges
        @room_rate = room_rate * (@check_out - @check_in).to_i
      end
    end
  end
end
