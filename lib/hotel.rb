#module Hotel

#class Reservation
#dates, check in check out, cost, id
# As an administrator, I can access the list of all of the rooms in the hotel
# As an administrator, I can reserve a room for a given date range
# As an administrator, I can access the list of reservations for a specific date
# As an administrator, I can get the total cost for a given reservation
#work
require 'date'

module Hotel

  class Reservation
    attr_reader :room_number, :start_date, :end_date, :cost

		def initialize(room_number, date, cost=200)
			@room_number = room_number
			@start_date = date.start_date
			@end_date = date.end_date

      #put in something for a cost discount? if nill blah blah blah

			if @start_date == @date.end_date
				@cost = cost
			else
				@cost = cost * (@end_date - @start_date).to_i
			end
		end

    #date range business

    if @start_date > @end_date
      raise ArgumentError, "Start date cannot come after end date!"
    end

    def self.overlapping?(start_date, end_date, comparison_start_date, comparison_end_date)
      # start date is within comparison date range
      return true if start_date >= comparison_start_date && start_date < comparison_end_date
      # end date is within comparison date range
      return true if end_date >= comparison_start_date && end_date <= comparison_end_date
      return false
    end
  end #class reservation


  class Hotel_Rooms
    attr_reader :number, :id, :rate, :room_number

    def initialize(number)
      @number = number
      @id = id
      @rate = rate
      @room_number = room_number
    end

    def self.all
      rooms = []
      number = 0
      20.times do
        number += 1
        rooms << self.new(number)
      end
    end

    #xnumber of rooms numbered 1-20
    #cost 200/night/rooms
    #make sure only charged for when occupied, not check out
    #error for invalid date range


  end #end of class Hotel_Rooms






end #end of module hotel
