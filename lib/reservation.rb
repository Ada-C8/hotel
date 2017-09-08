require 'date'

module Hotel
  class Reservation
    attr_reader :checkin, :checkout, :room

    def initialize(checkin_date, checkout_date, room_number)
      if valid_dates?(Date.parse(checkin_date), Date.parse(checkout_date))
        @checkin = Date.parse(checkin_date)
        @checkout = Date.parse(checkout_date)
        @room = room_number
      end
    end

    def valid_dates?(checkin, checkout)
      if checkin > checkout
        raise ArgumentError.new("Check-in date must be before check-out date")
      elsif !(Date.valid_date?(checkin.year, checkin.month, checkin.day)) || !(Date.valid_date?(checkout.year, checkout.month, checkout.day))
        raise ArgumentError.new("Your check-in and/or check-out date(s) are not valid")
      elsif checkin < Date.today
        raise ArgumentError.new("Check-in date must not be in the past.")
      else
        return true
      end
    end

    def cost
      (checkout - checkin) * STANDARD_RATE
    end
  end
end
