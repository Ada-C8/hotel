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
        blocks_for_date = number_rooms_blocked_by_date_range(check_in, check_out)
        wanted_dates = get_date_range(check_in, check_out)
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

        available_rooms = @all_rooms - reserved_rooms_for_dates
        if blocks_for_date >= available_rooms.length
          raise ArgumentError.new("Blocks for this date prohibit us from reserving rooms")
        else
          available_rooms
        end
      end#rooms_available


      def reservations_by_name(name_request)
        finder( name_request, :name, reservations_list)

      end#reservations_by_date

      def reservations_by_date(date)
        finder(date, :date_range, reservations_list )
      end#reservations_by_date
    end
  end
end
