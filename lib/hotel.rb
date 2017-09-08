
#mark with x when done


#   I can access the list of all of the rooms in the hotel
# x I can reserve a room for a given date range
#   I can access the list of reservations for a specific date
# x I can get the total cost for a given reservation

# x number of rooms numbered 1-20
# x cost 200/night/rooms
# x make sure only charged for when occupied, not check out
# x error for invalid date range

#  I can view a list of rooms that are not reserved for a given date range
#  I can reserve an available room for a given date range
#  also, A reservation is allowed start on the same day that another reservation for the same room ends
#  should raise an exception when asked to reserve a room that is not available

require 'date'

module Hotel

  class DateRange

    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)

      @start_date = start_date
      @end_date = end_date #should this be under the if as an else?

      if @start_date > @end_date
        raise ArgumentError, "Start date cannot come after end date"
      end
    end



    # add in the comp date and such for this logic
    def self.overlapping?(start_date, end_date, comparison_start_date, comparison_end_date)
      # start date is within comparison date range
      return true if start_date >= comparison_start_date && start_date < comparison_end_date
      # end date is within comparison date range
      return true if end_date >= comparison_start_date && end_date <= comparison_end_date
      return false
    end


  end #end of class DateRange

  class Reservation
    attr_reader :room_number, :start_date, :end_date, :cost

    def initialize(room_number, date, cost=200)
      @room_number = room_number
      @start_date = date.start_date
      @end_date = date.end_date


      if date.start_date == date.end_date
        @cost = cost
      else
        @cost = cost * (@end_date - @start_date).to_i
      end
    end

  end #end of class Reservations







  class Room

    attr_reader :room_number, :id, :rate

    def initialize(room_number)
      @room_number = room_number
      @id = id
      @rate = rate
    end

    # this was moved/refactored to hotelreservations
    # def self.all
    #   rooms = []
    #   number = 0
    #   20.times do
    #     number += 1
    #     rooms << self.new(number)
    #   end



  end #end of class Hotel_Rooms










  class ReservationSystem

    attr_reader :rooms, :room_reservation

    def initialize

      @rooms = []
      @room_reservation = {}

      @blocked_rooms = []
      20.times do |r|
        @rooms << Hotel::Room.new(r)
        @room_reservation[r] = []
      end

    end














  end #end of class ReservationSystem

end #end of module hotel
