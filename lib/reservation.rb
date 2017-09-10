require 'date'

module Hotel
  class Reservation
    attr_reader :name, :checkin, :checkout, :room

    def initialize(args)
      if valid_dates?(Date.strptime(args[:checkin], '%m-%d-%Y'), Date.strptime(args[:checkout], '%m-%d-%Y'))
        @name = args[:name]
        @checkin = Date.strptime(args[:checkin], '%m-%d-%Y')
        @checkout = Date.strptime(args[:checkout], '%m-%d-%Y')
        @room = args[:room]
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
