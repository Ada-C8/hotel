# require_relative 'hotel'
require_relative 'reservation'
require 'date'
require 'pry'
module Hotel

  #
  # def get_date_range(check_in, check_out)
  #   return  (check_in ... check_out).to_a
  # end

  class Admin
    attr_reader :reservations_list, :all_rooms

    def initialize
      @reservations_list = []
      @all_rooms = []
      make_hotel_rooms
    end

    def make_hotel_rooms
      (1..20).each do |num|
        @all_rooms << num #Hotel::Room.new(num) I don't think I have to do this
      end
    end


    def get_date_range(check_in, check_out)
      return  (check_in ... check_out).to_a
    end

    def reserve(check_in, check_out, room, name, contact_info)
      #checks that the date hash't been previously reserved

      raise ArgumentError.new("This room is already reserved on these days") if rooms_available?(check_in, check_out).include?(room) == false
      new_reservation = Hotel::Reservation.new(check_in, check_out, room, name, contact_info)

      @reservations_list << new_reservation


    end#reserve

    def rooms_available?(check_in, check_out)
      # binding.pry
      # #searches through the reservation list to find available rooms
      # #not sure if this will work  the .each.each is a little crazy TODO check for some sort of sweeeeeet enumerable to use on this bad boy.
      check_in_date = Date.new(check_in[0], check_in[1], check_in[2])
      check_out_date = Date.new(check_out[0], check_out[1], check_out[2])
      wanted_dates = get_date_range(check_in_date, check_out_date)
      reserved_rooms_for_dates = []

      case
      when @reservations_list == []
        return @all_rooms
      else
        @reservations_list.each do |reservation|
          #needs to check if the room is included in this reservation on the day

          overlap =  reservation.dates_reserved & wanted_dates
          overlap.any? ? reserved_rooms_for_dates << reservation.room : false

        end
      end
    return @all_rooms - reserved_rooms_for_dates
    end#rooms_available

    def reservations_by_date(date)
      date_find = Date.new(date[0], date[1], date[2])
      #go through reservations list and return array with all that contain the date
      reservations_list.find_all{|reservation| reservation.date_range.include?(date_find)}
    end#reservations_by_date
  end #class Admin

end #module Hotel
