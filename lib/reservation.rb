require "date"
require_relative "room"
require_relative "assign_room"

require "pry"

module Hotel
  class Reservation
    attr_accessor :rooms, :reservations, :stay_array

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

    def available_room
      # @rooms.each do |room|
      #   #unless room is reserved, return the first room
      #   #add later!
      #   return room
      # end

      #push reservation room numbers into array
      res_nums = []
      @reservations.each do |res|
        res_nums << res.room_number.num
      end
      #compare hotel room numbers with res_nums
      @rooms.each do |room|
        unless res_nums.include? room.num
          return room #returns first available room
        end
      end
    end

    def reserve_room(date_range, available_room)
      #take available_room and date_range,shove them into a new assign_room instance
      #this should be referencing a new class
      #assign_room should be added to @reservation array
      @reservations << Hotel::AssignRoom.new(date_range, available_room)
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
        if (res.date_range & date_range).empty?
          available_rooms << res
        end
      end

      return available_rooms
    end

  end #end class reservation
end #end module Hotel

# pokemon_hotel = Hotel::Reservation.new
#
# b_dates = pokemon_hotel.date_range("11-5-2017","11-8-2017")
# b_num = pokemon_hotel.available_room
# pokemon_hotel.reserve_room(b_dates, b_num)

# c_dates = pokemon_hotel.date_range("11-4-2017","11-7-2017")
# c_num = pokemon_hotel.available_room
# pokemon_hotel.reserve_room(c_dates, c_num)
#
# s_dates = pokemon_hotel.date_range("11-7-2017","11-9-2017")
# s_num = pokemon_hotel.available_room
# pokemon_hotel.reserve_room(s_dates, s_num)
# puts pokemon_hotel.reservations
# pokemon_hotel.reservations.each do  |res|
#   res.room_number.each do |i|
#     puts i.num
#   end
# end
# g_dates = pokemon_hotel.date_range("11-4-2017", "11-6-2017")
# p pokemon_hotel.available_rooms_during(g_dates)
