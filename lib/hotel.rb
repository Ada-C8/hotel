require 'pry'
require 'date'
require_relative 'reservation'
require_relative 'reservation_list'
require_relative 'date_range'
require_relative 'block'

module Hotel
  class Hotel

    attr_reader :all_rooms, :reservations, :block

    def initialize
      @block = Block.new
      @reservations = ReservationList.new
      @all_rooms = {1 => 200, 2 => 200, 3 => 200, 4 => 200, 5 => 200, 6 => 200, 7 => 200, 8 => 200, 9 => 200, 10 => 200, 11 => 200, 12 => 200, 13 => 200, 14 => 200, 15 => 200, 16 => 200, 17 => 200, 18 => 200, 19 => 200, 20 => 200}
    end

    def make_reservation(id, day_in, day_out, discount: 0, number_of_rooms: 1, room: 0, block_code: nil)
      if open_rooms(day_in, day_out).length >= 1
        first_open = open_rooms(day_in, day_out)[0]
        @reservations.add(id, day_in, day_out, room: first_open)
      else
        return "No Available Rooms for this date range"
      end
    end #make_reservation

    #I can access the list of reservations for a specific date
    def find_reservations(day_in, day_out)
      found_reservations = Array.new
      DateRange.create_range(day_in, day_out).each do |date|
        found_reservations << @reservations.reservation_list.find_all { |reservation| reservation.nights_reserved.include?(Date.parse(date)) }
      end #each date
      return found_reservations.flatten.uniq
    end #find_reservations

    # I can get the total cost for a given reservation
    def total_cost(reservation_id)
      @reservations.reservation_list.each do |reservation|
        if reservation.id == reservation_id
          return reservation.total_cost
        else
          return "Reservation Not Found"
        end #end if
      end #end each
    end #end total cost

    #I can reserve an available room for a given date range
    def is_available?(id, number_of_rooms, day_in, day_out)
      if open_rooms(day_in, day_out) <= number_of_rooms
        #first_available =
        return true
      else
        return false
      end  #if/else
    end# is_available

    #I can view a list of rooms that are not reserved for a given date range
    def open_rooms(day_in, day_out)
      occupied_rooms = Array.new
      find_reservations(day_in, day_out).each do |reservation|
        occupied_rooms << reservation.room
      end
      open_rooms = (@all_rooms.keys - occupied_rooms)
      return open_rooms
    end


    #As an administrator, I can create a block of rooms
    #you should just be blocking off the rooms so it's only available to actually make the reservation if they have the code -- but it needs to remove the room from the list of open rooms?
    #maybe a reservation status like confirmed or just held for block? than it can change to confirmed if they have the code?
    def create_block(block_id, number_of_rooms, day_in, day_out, discounted_rate)
      available = open_rooms(day_in, day_out)
      if available.length >= number_of_rooms
        available.take(number_of_rooms).each do |room|
          make_reservation(block_id, room, day_in, day_out, discount: discounted_rate, block_status: held)
          #have a status like held for reservation? Then they can only reserve it with the code?
        end#each
      else
        return "There are only #{available.length} rooms available during the requested dates."
      end #if statment
    end
  end #class
end #module

# @boetel = Hotel::Hotel.new

# @hotel = Hotel::Hotel.new
# @hotel.make_reservation(2222, "2012/12/12", "2012/12/15", room: 2)
# @hotel.make_reservation(2224, "2012/12/13", "2012/12/17", room: 10)
# x = @hotel.open_rooms("2012/12/12", "2012/12/13")
# #@hotel.open_rooms("2012/12/12", "2012/12/13")[0].must_equal 1
# # @boetel.make_reservation(1201, "2017/12/12", "2017/12/14")
# # @boetel.make_reservation(1202, "2017/12/10", "2017/12/12")
# # @boetel.make_reservation(1203, "2017/12/12", "2017/12/15")
# # @boetel.make_reservation(1204, "2017/12/14", "2017/12/16")
# binding.pry
# @boetel.find_reservations("2017/12/14", "2017/12/15")
# open = @boetel.open_rooms("2017/12/12", "2017/12/14")



# @boetel.make_reservation(1205, 5, "2017/12/1", "2017/12/15")
# @boetel.make_reservation(1206, 6, "2017/12/1", "2017/12/15")
# @boetel.make_reservation(1207, 7, "2017/12/1", "2017/12/15")
# @boetel.make_reservation(2308, 8, "2017/12/13", "2017/12/17")
# @boetel.make_reservation(1230, 1, "2017/12/5", "2017/12/10")
# @boetel.make_reservation(1201, 1, "2017/12/10", "2017/12/15")




#binding.pry

# find if rooms is open for a given date range
# reserve room for that date range
#what will my reservation object look like
#in my fictional interface
#check whether a room is available on desired dates using reservation list
#if available, should instantiate a new instance of reservation using the reservation class
#if not available, go to next room and check.
#if you reach the end of the list, report that no reservation is possible during that time
