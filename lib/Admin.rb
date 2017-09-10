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



    def add_reservation(room_num, check_in, check_out)
      @reservations << Reservation.new(room_num, check_in, check_out)
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


    # lists room vacancies that can be utilized for booking available rooms
    def list_vacancies(check_in, check_out)
      available_rooms = list_of_rooms

      date_range = DateRange.new(check_in, check_out).date_range_array

      date_range.each do |date|
        reservations.each do |reservation|
          if reservation.date_range_array.include?(date)
            available_rooms.delete(reservation.room_num)
          end
        end
      end # end date_range loop
      return available_rooms
    end


    # reserves available room for a given date range.
    def reserve_by_date(check_in, check_out)
      room_num = self.list_vacancies(check_in, check_out).sample
      Hotel::Reservation.new(room_num, check_in, check_out, discount_percent: 0.0)
    end
  end # end class
end # end module
