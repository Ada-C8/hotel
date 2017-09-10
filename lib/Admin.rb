require_relative 'reservation'

module Hotel
  class Admin

    attr_reader :room_nums, :reservations

    def initialize

      @reservations = []


      @room_nums = []
      20.times do |i|
        @room_nums << (i + 1)
      end
    end

    def list_of_rooms
      return Array.new(room_nums)
    end

    def add_reservation(room_selection, check_in, check_out)
      @reservations << Hotel::Reservation.new(room_selection, check_in, check_out)
    end

    def list_reservations(date)
      rez_by_date = []

      @reservations.each do |reservation|
        if reservation.date_range_array.include?(date)
          rez_by_date << reservation
        end
      end

      return rez_by_date
    end


    def list_vacancies(check_in, check_out)
      available_rooms = list_of_rooms

      date_range = Hotel::DateRange.new(check_in, check_out).date_range_array

      date_range.each do |date|
        reservations.each do |reservation|
          if reservation.date_range_array.include?(date)
            available_rooms.delete(reservation.room_num)
          end

        end
      end

      return available_rooms
    end


  end
end

# puts Hotel::Admin.new.room_selection

# room_num1 = 1
# check_in = Date.new(2017,2,3)
# check_out = Date.new(2017, 2,7)
# # # puts Hotel::DateRange.new(check_in, check_out).date_range_array
# # reservation = Hotel::Reservation.new(room_num1, check_in, check_out)
# #
# # puts "#{reservation.room_nums}"
#
#
# puts Hotel::Admin.new.add_reservation(room_num1, check_in, check_out)
#
# puts "This should be the reservations array #{Hotel::Admin.new.reservations}"
