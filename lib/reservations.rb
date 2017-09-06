require 'date'
module Hotel
  class Reservations

     attr_reader :dates

    def initialize
      # @all_rooms = [1..20] # do I need all_rooms?
      @rooms = Room.new.room_number
      # @room_cost = 0 # do I need this? I have cost over in booking
      # @cost = Room.new.cost
      @all_reservations = []
    end

    # Booking.new(checkin, checkout, check_availablity[0])

    def make_reservation(checkin, checkout, num_of_rooms = 1)

      # create date range
      check_availability
      # do we have an availability?
      # if yes, Reservation.new and push into @all_reservations
      # make id here and pass into booking

    end

    def check_reservation(checkin, checkout)
      if checkin.include? (date_range)
      end
      @all_reservations
      # need to check each find date
      # if reservation.date.include? (date_range[0])
      #   not_available << room
    end

    def check_availablity

      # this will be the inverse of not_available array
    end



  end
end
