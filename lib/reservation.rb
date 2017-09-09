require_relative "room"
require "date"
require "pry"

module Hotel
  class Reservation
    attr_accessor :reservations, :stay_array

    def initialize
      @rooms = Hotel::Room.all
      @reservations = []
    end

    #strptime could be added all at once here instead?
    #  used for adding array in reserve_room
    #  will use for checking availability in available_room
    def date_range(check_in, check_out)
      check_in = Date.strptime(check_in, "%m-%d-%Y") #keep this method for date
      check_out = Date.strptime(check_out, "%m-%d-%Y") #month-day-fullyear
      @stay_array = []
      (check_in..check_out).each do |d|
        @stay_array << "#{d.month}-#{d.day}-#{d.year}"
      end
      return @stay_array
    end

    def available_room #returns number array of rooms
      @rooms.each do |room|
        #unless room is reserved, return the first room
        #add later!
        return room
      end
    end

    def reserve_room(date_range, available_room)
      #take available_room and date_range,shove them into a new assign_room instance
      #this should be referencing a new class
      #assign_room should be added to @reservation array
      reserved = Hotel::AssignRoom.new(date_range, available_room)
      @reservations << reserved
    end

    def total
      return "$#{(stay_array.length-1) * 200}.00"
    end

    def search_reservations(date)
      reservations_by_date = []
      @reservations.each do |arr|
        if arr[0].include? date
          reservations_by_date << arr
        end
      end
      return reservations_by_date
    end

  end #end class reservation
end #end module Hotel
