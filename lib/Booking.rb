### Booking Program class that holds all of the business logic for the hotel and the reservation system
require 'date'
require 'pry'
require_relative 'Reservation'
require_relative 'Room'

#TODO 09/07/2017:Design logic: Rooms have reservations, have dates, BUT CURRENTLY, Rooms store reservations and all dates on which they are reserved, and that is used to check quickly what rooms are available.
#Rooms also store a hash of Reservation id keys, with their corresponding dates as values, which seems superfluous. RECONSIDER THIS DESIGN. Should Rooms hold Reservation objects only? Reservation objects and dates reserved? maybe just reservation ids and dates? Maybe just reservation ids and helper method that will retrieve the reservation as needed? Think through


module Hotel
  # NUMBER_OF_ROOMS = 20  ### might not want to use constant, especially if we have subclasses of rooms (by type), and each room subclass might have a different number. may best be a constant defined by class/subclass

  class BookingProgram
    attr_reader :all_rooms, :all_reservations

    def initialize # do we want to initialize with hotel name?
      @all_rooms = Hotel::Room.all # returns an array or hash of Room objects
      @all_reservations = []

    end

    def available_rooms(check_in,check_out)
      #check_in and #check_out are strings
      #TODO: below
      # confirm check_out date availability logic
      #error handling
      #message if no rooms are available?
      @all_rooms.select {|room| room.available_all_days?(check_in, check_out)}
    end

    def make_reservation(check_in,check_out,room_id, guest_id=nil)

      reservation = Hotel::Reservation.new(check_in,check_out,room_id, guest_id)
      reservation.id += 1 #something

      reservation.room.reserve_room(check_in,check_out,reservation.id, guest_id)

      @all_reservations << reservation

    end

    def find_res_by_date(date_str)
      date_object= Date.parse(date_str)
      reserved_on_date = []
      @all_reservations.each {|reservation| reserved_on_date << reservation if reservation.room.all_dates.include?(date_object)}

      return reserved_on_date

      #self.all.select {|reservation| reservation.room.all_dates.include?(date_object)}
    end

    # def find_res_by_guest(guest_id)
    # end
    #

    #
    # def find_res_by_room(room_id)
    # end

    #def find_res_by_id(reservation_id)
    #end

  end

end


# binding.pry

#########WAVE 2 #####
