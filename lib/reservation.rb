require_relative "hotel"
require "date"
require "pry"

module Hotel
  class Reservation
    attr_accessor :hotel, :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = Date.strptime(check_in, "%m-%d-%Y") #keep this method for date
      @check_out = Date.strptime(check_out, "%m-%d-%Y") #month-day-fullyear

    end

    #strptime could be added all at once here instead?
    def date_range
      stay_array = []
      (@check_in..@check_out).each do |d|
        stay_array << "#{d.month}-#{d.day}-#{d.year}"
      end
      return stay_array
    end

    def self.available_room
      #are there rooms with no dates?
      #present them and pick room at random

      Hotel::Room::all.map {|room| room}
    end

    def reserve_room
      #add dates to room

    end


    def total
      #total  = (dates.length-1) * 200
    end

  # private
  #   def available?
  #     unless @dates == 0 || @dates == nil
  #       @reserved = true
  #     end
  #   end

  end #end class reservation
end #end module Hotel
dates = Hotel::Reservation.new("12-5-2017","12-17-2017")
puts dates
puts dates.date_range

print self.available_room

# def request_dates(check_in, check_out)#default to check_in date if not provided?
#   #date-format: shouldn't matter based on Chronic
#   #"1-1-17", "jan 1, 17" should still be in quotes
#   #@dates = {}
#   @check_in = Chronic.parse()
#   @check_out = Chronic.parse()
#   #  hotel = Hotel::Room.all
#   #  hotel[0].dates[:check_in] = check_in
#   #  hotel[0].dates[:check_out] = check_out
#   #based on dates
#   #based on rooms
# end
