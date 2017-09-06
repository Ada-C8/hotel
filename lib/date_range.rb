# DateRange must be a class that takes two arguments: the starting date of the reservation and the ending date of the reservation

#start_date end_date will be created in the Booking class as instances of the Date class

# DateRange must use the start_date and end_date to create an array of all the days included in that range, not including the checkout day because the room is availible again on the checkout day

module Hotel
  class DateRange
    attr_reader :start_date, :end_date, :num_nights
    def initialize(start_date, end_date)
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

    # TODO: do I need to make a method to print out the date range in string format for the user?

  end # DateRange
end # Hotel
