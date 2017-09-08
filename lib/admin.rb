require_relative './concerns/dateable'
require_relative './concerns/reserveable'
require_relative 'reservation'
require 'date'
require 'pry'
module Hotel


  class Admin
    include Hotel::Dateable::InstanceMethods
    include Hotel::Reserveable::InstanceMethods

    attr_reader :reservations_list, :all_rooms
    # def get_date_range(check_in, check_out)
    #   return  (check_in ... check_out).to_a
    # end

    def initialize
      @reservations_list = []
      @block_list = {}
      @all_rooms = []
      make_hotel_rooms
    end
    #could possibly go back in here and use a rooms class
    def make_hotel_rooms
      (1..20).each do |num|
        @all_rooms << num #Hotel::Room.new(num) I don't think I have to do this
      end
    end
    #
    #
    # def reserve(check_in, check_out, room, name, contact_info)
    #   #checks that the date hash't been previously reserved, and there are enough rooms for the blocks
    #
    #   raise ArgumentError.new("This room is already reserved on these days") if rooms_available?(check_in, check_out).include?(room) == false
    #   new_reservation = Hotel::Reservation.new(check_in, check_out, room, name, contact_info)
    #
    #   @reservations_list << new_reservation
    #
    #
    # end#reserve
    #
    # def rooms_available?(check_in, check_out)
    #   # binding.pry
    #   # #searches through the reservation list to find available rooms
    #
    #   check_in_date = Date.new(check_in[0], check_in[1], check_in[2])
    #   check_out_date = Date.new(check_out[0], check_out[1], check_out[2])
    #   wanted_dates = get_date_range(check_in_date, check_out_date)
    #   reserved_rooms_for_dates = []
    #   blocks_for_date = 0
    #
    #   case
    #   when @reservations_list == []
    #     return @all_rooms
    #   else
    #     @reservations_list.each do |reservation|
    #       #needs to check if the room is included in this reservation on the day
    #
    #       overlap =  reservation.dates_reserved & wanted_dates
    #       overlap.any? ? reserved_rooms_for_dates << reservation.room : false
    #
    #     end
    #   end
    #   #if blocks_for_date.length <= (@all_rooms - reserved_rooms_for_dates).length ? @all_rooms - reserved_rooms_for_dates : raise ArgumentError.new("Blocks for this date prohibit us from reserving rooms")
    #   return @all_rooms - reserved_rooms_for_dates
    # end#rooms_available
    #
    #
    # #ability to do reservation things
    # def reservation_finder(search_term, instance_variable)
    #   reservations_list.find_all{|reservation| reservation.send(instance_variable).include?(search_term)}
    # end
    #
    # def reservations_by_name(name_request)
    #   reservation_finder( name_request, :name )
    #
    # end#reservations_by_date
    #
    # def reservations_by_date(date)
    #   date_find = Date.new(date[0], date[1], date[2])
    #   reservation_finder(date_find, :date_range )
    # end#reservations_by_date

    #ablity to do block things
    #what I want to do is block off the amount of rooms that are required for the block
    #can change number of blocks in reserved block
    def create_block(name, check_in, check_out, num_rooms)
    end

    def change_number_blocks(block_id, amount)
    end

    def convert_block_to_res(block_id)
    end

  end #class Admin

end #module Hotel
