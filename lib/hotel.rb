require 'pry'

module Hotel
  class Hotel

    attr_reader :all_rooms, :reservation_list

    def initialize
      @all_rooms = {1 => 200, 2 => 200, 3 => 200, 4 => 200, 5 => 200, 6 => 200, 7 => 200, 8 => 200, 9 => 200, 10 => 200, 11 => 200, 12 => 200, 13 => 200, 14 => 200, 15 => 200, 16 => 200, 17 => 200, 18 => 200, 19 => 200, 20 => 200}
      @reservation_list = []
    end

# As an administrator, I can access the list of all of the rooms in the hotel
    # def show_rooms
    #   room_list = ""
    #   @all_rooms.each do |number, cost|
    #     room_list += "Room #{number}:\t$#{cost}\n"
    #   end
    #   return room_list
    # end

# - As an administrator, I can reserve a room for a given date range
    def make_reservation(date_range)
      #check whether a room is available on desired dates using reservation list
      #if available, should instantiate a new instance of reservation using the reservation class
      #if not available, go to next room and check.
      #if you reach the end of the list, report that no reservation is possible during that time
    end

    # - As an administrator, I can access the list of reservations for a specific date
    def view_reservations(date)
      #enter a date
      #list all rooms reserved for that date from reservation list
    end

    def total_cost(reservation)
      #enter reservation ID number
      #return total cost for that reservation
    end
    # - As an administrator, I can get the total cost for a given reservation

    # def is_avail(room, date)
    #   #put in room number and single date
    #   #should look at all the reservations for that room for that date
    # end




  end #class
end #module
binding.pry

# find if rooms is open for a given date range
# reserve room for that date range

#rooms = {}
#view_avail(Date)
#view_booked(Date)
#reservations list
#is_avail? room date
#make_reservation
