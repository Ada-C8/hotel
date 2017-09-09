require_relative "room"
require "date"
require "pry"

module Hotel
  class Reservation
    attr_accessor :check_in, :check_out

    def initialize
      @rooms = Hotel::Room.all
      @check_in = check_in
    end

    #strptime could be added all at once here instead?
    #  used for adding array in reserve_room
    #  will use for checking availability in available_room
    def date_range(check_in, check_out)
      @check_in = Date.strptime(check_in, "%m-%d-%Y") #keep this method for date
      @check_out = Date.strptime(check_out, "%m-%d-%Y") #month-day-fullyear
      stay_array = []
      (@check_in..@check_out).each do |d|
        stay_array << "#{d.month}-#{d.day}-#{d.year}"
      end
      return stay_array
    end

    # def available_room #returns number array of rooms
    #   #are there rooms with no dates?
    #   #present them
    #   available = []
    #   @hotel.each do |room|
    #     if room.dates.length == 0
    #       available << room.num
    #     end
    #   end
    #   return available
    # end
    #
    # def reserve_room
    #   #pick room at random (from the available list)
    #   #add dates to room
    #   #create a reservation
    #   if available_room.length > 0
    #     @room = available_room.sample #finds instance of room
    #     @room.dates << date_range
    #     @room.dates.flatten! #removes nested array
    #     #update available_room?
    #     available_room
    #     # return @room.dates
    #   end #create a way to schedule within other schedules .include
    #   available_room
    #   return @room.dates
    # end
    #
    # def total
    #   return "$#{(reserve_room.length-1) * 200}.00"
    # end
    #
  # private
  #
  #   def available?
  #     if @room.dates.length > 0
  #       @room.reserved = true
  #     end
  #   end

  end #end class reservation
end #end module Hotel

this = Hotel::Reservation.new

this.date_range("12-8-2017", "12-13-2017")
