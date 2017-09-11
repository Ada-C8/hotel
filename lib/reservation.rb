require "date"
require_relative "room"
require_relative "assign_room"

require "pry"

module Hotel
  class Reservation
    DATE = /^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}$/
    attr_accessor :rooms, :reservations, :stay_array

    def initialize
      @rooms = Hotel::Room.all
      @reservations = []
    end

    #strptime could be added all at once here instead?
    #  used for adding array in reserve_room
    #  will use for checking availability in available_room
    def date_range(check_in, check_out)
      #test regex, test dates in past
      arr = []
      arr << check_in
      arr << check_out
      arr.each do |date_entered|
        if DATE.match(date_entered)
          if Date.strptime(date_entered, "%m-%d-%Y") < Date.today
            raise ArgumentError.new("These are dates in the past")
          end
        else
          raise ArgumentError.new("Date does not match XX-XX-XXX format")
        end
      end
      #test dates in ascending order
      check_in = Date.strptime(check_in, "%m-%d-%Y") #keep this method for date
      check_out = Date.strptime(check_out, "%m-%d-%Y") #month-day-fullyear
      if check_out < check_in
        raise ArgumentError.new("Dates are in an invalid range/wrong order?")
      end
      #create range
      @stay_array = []
      (check_in..check_out).each do |d|
        @stay_array << "#{d.month}-#{d.day}-#{d.year}"
      end
      return @stay_array

    end

    def available_room
      #takes rooms with no reservations
      res_nums = []
      @reservations.each do |res|
        res_nums << res.room_number.num
      end
      @rooms.each do |room|
        unless res_nums.include? room.num
          return room #returns first instance
        end
      end

    end

    def reserve_room(date_range, available_room)
      #take available_room and date_range,shove them into a new assign_room instance

      #check valid available_room
      if available_rooms_during(date_range).include? available_room
        @reservations << Hotel::AssignRoom.new(date_range, available_room)
      else
        raise ArgumentError.new("This room isn't available")
      end
    end

    def total
      return "$#{(stay_array.length-1) * 200}.00"
    end

    def reservations_by_date(date) #find reservations by date
      array = []
      @reservations.each do |arr|
        if arr.date_range.include? date
          array << arr
        end
      end
      return array
    end


    def available_rooms_during(date_range)
      #available rooms during requested date range
      #date_range must first be defined
      #list all rooms that will be available
      available_rooms = []

      #takes rooms with no reservations
      res_nums = []
      @reservations.each do |res|
        res_nums << res.room_number.num
      end
      @rooms.each do |room|
        unless res_nums.include? room.num
          available_rooms << room
        end
      end

      #takes available rooms in date_range from @reservations
      @reservations.each do |res|
        nights = res.date_range
        nights.pop #removes check out day
        if (nights & date_range).empty?
          available_rooms << res
        end
      end

      return available_rooms
    end

  end #end class reservation
end #end module Hotel
