require 'date'

module Hotel
  class Booking
    attr_reader :id, :dates, :total_cost, :rooms
    #Has_a relationship with Reservations
    #need to be a

    #price/night

    # each reservation needs an id, room number, and a total cost
    def initialize(checkin, checkout)
      @dates = DateRange.new(checkin, checkout)
      @id = 0

      @total_cost = 0
      @rooms = rooms
    end

    def define_total_cost
      # Hotel::DateRange.new(checkin, checkout)
      
      #How do I tell it to go over to DateRange and get the total_nights instance variable?
      @total_cost = (Hotel::DateRange.total_nights * 200)
      return @total_cost
    end

    # date_range
    # .length

  end
end
