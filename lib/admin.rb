require_relative 'hotel'
require_relative 'reservation'

module Hotel

  class Admin
    attr_reader :reservations_list

    def initialize
      @reservations_list = {}

    end

    def reserve(date_range, room, name, contact_info)
      #checks that the date hash't been previously reserved
      #not sure if this will work  the .each.each is a little crazy TODO check for some sort of sweeeeeet enumerable to use on this bad boy.
      @reservations_list[date_range.each].each do |reservation|
        raise ArgumentError.new("Room already reserved for this day") if reservation.room == new_reservation.room
      end
        new_reservation = Hotel::Reservation.new(date_range, room, name, contact_info)

        #TODO date_range.each do |date|
      case
      when @reservations_list[date] == nil
        @reservations[date] = new_reservation
      else
        @reservations[date] << new_reservation
      end#case

    end#reserve

    def rooms_available(check_in, check_out)
      #searches through the reservation list to find available rooms
    end#rooms_available

  end #class Admin

end #module Hotel
