require_relative 'hotel'
require_relative 'reservation'

module Hotel

  class Admin
    attr_reader :reservations_list

    def initialize
      @reservations_list = {}
      @all_rooms = []
      make_hotel_rooms
    end

    def make_hotel_rooms
      (1..20).each do |num|
        @all_rooms << num #Hotel::Room.new(num) I don't think I have to do this
      end
    end

    def reserve(check_in, check_out, room, name, contact_info)
      #checks that the date hash't been previously reserved

      raise ArgumentError.new("This room is already reserved on these days") if rooms_available?(check_in, check_out).include?(room) == false
      new_reservation = Hotel::Reservation.new(check_in, check_out, room, name, contact_info)

      @reservations_list << new_reservation


    end#reserve

    def rooms_available?(check_in, check_out)
      #searches through the reservation list to find available rooms
      #not sure if this will work  the .each.each is a little crazy TODO check for some sort of sweeeeeet enumerable to use on this bad boy.
      reserved_rooms_for_dates = []
      @reservations_list[check_in, check_out].each do |reservation|
        #needs to check if the room is included in this reservation on the day

        overlap =  reservation.dates_reserved & [check_in .. check_out]
        overlap.any? ? false : reserved_rooms_for_dates << reservation.room

      end
      rooms_avalable = @all_rooms - reserved_rooms_for_dates
    end#rooms_available

  end #class Admin

end #module Hotel
