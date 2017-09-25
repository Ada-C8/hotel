# DateRange must be a class that takes two arguments: the starting date of the reservation and the ending date of the reservation

#start_date end_date will be created in the Booking class as instances of the Date class

# DateRange must use the start_date and end_date to create an array of all the days included in that range, not including the checkout day because the room is availible again on the checkout day

module Hotel
  class DateRange
    attr_reader :start_date, :end_date, :num_nights
    def initialize(start_date, end_date)

      # I moved this validation here from the valid_dates method in Booking 
      if end_date <= start_date
        raise BookingError.new("Your checkout day must be after your checkin date! You entered: checkin day = #{start_date} and checkout date = #{end_date}")
      end

      @start_date = start_date
      @end_date = end_date
      @num_nights = (end_date - start_date).to_i
    end # initialize

    #creates an array (nights_occupied) that containts all the days where the room is occupied for that night
    def nights_booked
      nights_occupied = []
      counter = 0
      @num_nights.times do
        nights_occupied << (@start_date + counter)
        counter += 1
      end
      return nights_occupied
    end # nights_booked

    end # DateRange
  end # Hotel
