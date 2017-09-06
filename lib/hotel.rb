require_relative 'room'

module Hotel_System
  class Hotel
    attr_reader :number_of_rooms, :rooms
    def initialize(number_of_rooms)
      @number_of_rooms = number_of_rooms
      @rooms = []
      number_of_rooms.times do |i|
        @rooms << Hotel_System::Room.new(i + 1)
      end
    end

    def reservations
      reservations = []
      @rooms.each do |room|
        if room.reservations != []
          reservations += room.reservations
        end
      end
      return reservations
    end

    def find_res_by_date(date)
      all_reservations = self.reservations
      date_reservations = all_reservations.select do |reservation|
        (reservation.check_in...reservation.check_out).cover?(date)
      end
      return date_reservations
    end

    def find_avail_rooms(date)
      date_reservations = self.find_res_by_date(date)
      reserved_rooms = date_reservations.map {|reservation| reservation.room }
      avail_rooms = self.rooms.reject {|room| reserved_rooms.include?(room.room_number)}
      return avail_rooms
    end
  end
end
