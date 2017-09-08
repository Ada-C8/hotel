require 'pry'
require 'date'
require_relative 'reservation'
require_relative 'reservation_list'
require_relative 'date_range'

module Hotel
  class Hotel

    #@@reservations = []

    attr_reader :all_rooms, :reservations

    def initialize
      @reservations = ReservationList.new
      @all_rooms = {1 => 200, 2 => 200, 3 => 200, 4 => 200, 5 => 200, 6 => 200, 7 => 200, 8 => 200, 9 => 200, 10 => 200, 11 => 200, 12 => 200, 13 => 200, 14 => 200, 15 => 200, 16 => 200, 17 => 200, 18 => 200, 19 => 200, 20 => 200}
    end

    #As an administrator, I can access the list of all of the rooms in the hotel
    # def show_rooms
    #   room_list = ""
    #   @all_rooms.each do |number, cost|
    #     room_list += "Room #{number}:\t\t$#{cost}\n"
    #   end
    #   return room_list
    # end #show rooms

    # - As an administrator, I can reserve a room for a given date range
    def make_reservation(id, room, day_in, day_out)
      @reservations.add(id, room, day_in, day_out)
      #@@reservations << Reservation.new(id, room, day_in, day_out)
      #return #Hotel::ReservationList.reservations
    end #make_reservation

    # def self.reservations
    #   return @@reservations
    # end

    #As an administrator, I can access the list of reservations for a specific date
    # def self.find_reservation(date)
    #   date = Date.parse(date)
    #   reservation_list = []
    #   @@reservations.each do |reservation|
    #     if reservation.date_range.include?(date)
    #       reservation_list << reservation.view_reservation
    #     end
    #     return reservation_list
    #   end
    #   #list all rooms reserved for that date from reservation list
    # end #view_reservations
    # #As an administrator, I can reserve an available room for a given date range
    # def self.find_available_room(day_in, day_out)
    #   dates = DateRange.create_range(day_in, day_out) #should create an array
    #   occupied_rooms = []
    #   available_rooms = []
    #
    #   dates.each do |date|
    #     occupied_rooms << find_reservation(date)
    #   end
    #   occupied_rooms = occupied_rooms.compact
    #   return occupied_rooms
      # @@reservations.each do |reservation|
      #   if reservation.date_range.include?(date)
      #     occupied_rooms << reservation.id
      #   end #if

      #   end #reservations each
      # end #dates each
      #list all rooms reserved for that date from reservation list
    # end #find room
    # # - As an administrator, I can get the total cost for a given reservation
    # def self.total_cost(reservation_id)
    #   @@reservations.each do |reservation|
    #     if reservation.id == reservation_id
    #       return reservation.total_cost
    #     else
    #       return "Reservation Not Found"
    #     end #end if
    #   end #end each
    # end #end total cost

    #As an administrator, I can view a list of rooms that are not reserved for a given date range
    # =begin
    # create range of dates
    # for each date, check list of reservations, add room number to unavailable list
    #   nested loops
    #   at end return array of all rooms minus array of occupied rooms
    #   =end



  end #class
end #module
#binding.pry
binding.pry
# find if rooms is open for a given date range
# reserve room for that date range
#what will my reservation object look like
#in my fictional interface
#check whether a room is available on desired dates using reservation list
#if available, should instantiate a new instance of reservation using the reservation class
#if not available, go to next room and check.
#if you reach the end of the list, report that no reservation is possible during that time

# def self.view_all_reservations
#   @@reservations.each do |reservation|
#     return reservation.Reservation.view_reservation
#   end
# end

# def is_avail(room, date)
#   #put in room number and single date
#   #should look at all the reservations for that room for that date
# end

#rooms = {}
#view_avail(Date)
#view_booked(Date)
#reservations list
#is_avail? room date
