require 'date'
require 'DateRange'

module Hotel
  class InvalidDateError < StandardError
  end

  class Booking
    attr_reader :check_in, :check_out, :room_number, :total_cost
    def initialize(check_in, check_out, room_number = rand(1..20), room_rate = 200) #total_cost = 200)
      @room_number = room_number
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @date_range = DateRange.new(@check_in, @check_out)
      @dates = @date_range.dates
      @room_rate = room_rate
      #@dates = Hotel::DateRange.new(check_in, check_out)
      # @num_days = (@check_out - @check_in).to_i
      # @total_cost = (@room_rate * @num_days)
      @discount = 0

      validate_dates
    end

    def auto_assign_room_number

    end

    def validate_dates
      unless @check_in >= Date.today
        raise InvalidDateError.new("Check-in cannot be before today's date.")
      end
      unless @check_in < @check_out
        raise InvalidDateError.new("Check-in cannot be after check-out.")
      end
    end

    def total_cost
      num_days = (@check_out - @check_in).to_i
      total_cost = @room_rate * num_days
      return total_cost
    end
  end

end




# def valid_dates
#
# unless card_is_valid?(card_number)
# raise InvalidCardNumberError.new("Invalid credit card number #{card_number}")
# end
# # ... process the transaction ...
# end
