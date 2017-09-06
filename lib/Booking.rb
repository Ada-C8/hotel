### Booking Program class that holds all of the business logic for the hotel and the reservation system
require 'date'
require 'pry'
require_relative 'Reservation'
require_relative 'Room'

module Hotel
  # NUMBER_OF_ROOMS = 20  ### might not want to use constant, especially if we have subclasses of rooms (by type), and each room subclass might have a different number. may best be a constant defined by class/subclass

  class BookingProgram
    attr_reader :all_rooms, :all_reservations

    def initialize # do we want to initialize with hotel name?
      @all_rooms = Hotel::Room.all # returns an array or hash of Room objects
      @all_reservations = []

    end

    def make_reservation(guest_id, check_in,check_out,room_id)

      reservation = Hotel::Reservation.new(guest_id, check_in,check_out,room_id)
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

  end

end


# binding.pry

#########WAVE 2 #####

# def available_rooms(check_in,check_out)
#   # confirm check_out date availability logic
#   available_rooms  = []
#
#   candidates = @all_rooms.select {|room| room.available?(check_in) && room.available?(check_out)}
#
#   candidates.each do |room|
#     available_rooms << room if room.available_all_days?(check_in, check_out)
#   end
#
#   return available_rooms if available_rooms.count > 0
#   return false
# end
