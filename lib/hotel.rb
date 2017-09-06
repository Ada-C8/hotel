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
          reservations.push(room.reservations)
        end
      end
      return reservations
    end
    # def reserve_room(name, check_in, check_out)
    #   reservation = Hotel_System::Reservation.new(name, check_in, check_out)
    #   @reservations[:reservation.name] =
    # end
  end
end
