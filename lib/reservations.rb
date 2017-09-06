require 'date'
module Hotel
  class Reservations

     attr_reader :dates

    def initialize
      @all_rooms = [1..20]
      @room_cost = 0
      @all_reservations = []

    end

    
    def check_reservation(start_date, end_date)
      @all_reservations
      # need to check each find date
      # if reservation.date.include? (date_range[0])
      #   not_available << room
    end

    def check_availablity
      # this will be the inverse of not_available array
    end

    def make_reservation(checkin, checkout, num_of_rooms = 1)
      # create date range
      # do we have an availability?
      # if yes, Reservation.new and push into @all_reservations

    end



  end
end
