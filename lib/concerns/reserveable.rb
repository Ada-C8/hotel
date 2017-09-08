module Hotel
  module Reserveable
    module InstanceMethods
        include Hotel::Dateable::InstanceMethods


      def reserve(check_in, check_out, room, name, contact_info)
        #checks that the date hash't been previously reserved, and there are enough rooms for the blocks

        raise ArgumentError.new("This room is already reserved on these days") if rooms_available?(check_in, check_out).include?(room) == false
        new_reservation = Hotel::Reservation.new(check_in, check_out, room, name, contact_info)

        @reservations_list << new_reservation


      end#reserve

      def rooms_available?(check_in, check_out)
        # binding.pry
        # #searches through the reservation list to find available rooms

        check_in_date = Date.new(check_in[0], check_in[1], check_in[2])
        check_out_date = Date.new(check_out[0], check_out[1], check_out[2])
        wanted_dates = get_date_range(check_in_date, check_out_date)
        reserved_rooms_for_dates = []
        blocks_for_date = 0

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
        #if blocks_for_date.length <= (@all_rooms - reserved_rooms_for_dates).length ? @all_rooms - reserved_rooms_for_dates : raise ArgumentError.new("Blocks for this date prohibit us from reserving rooms")
        return @all_rooms - reserved_rooms_for_dates
      end#rooms_available


      #ability to do reservation things
      def reservation_finder(search_term, instance_variable)
        reservations_list.find_all{|reservation| reservation.send(instance_variable).include?(search_term)}
      end

      def reservations_by_name(name_request)
        reservation_finder( name_request, :name )

      end#reservations_by_date

      def reservations_by_date(date)
        date_find = Date.new(date[0], date[1], date[2])
        reservation_finder(date_find, :date_range )
      end#reservations_by_date
    end
  end
end
