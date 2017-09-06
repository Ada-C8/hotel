module Hotel
  class Hotel
    attr_reader :number_of_rooms, :list_of_rooms, :reservations

    def initialize(number_of_rooms)
      @number_of_rooms = number_of_rooms.to_i
      @reservations = []
      @list_of_rooms = create_list_of_rooms
    end

    def create_list_of_rooms
      list_of_rooms = Array.new
      @number_of_rooms.times do |i|
        list_of_rooms << Room.new(i+1)
      end
      return list_of_rooms
    end

    def make_reservation(client, arrival_year, arrival_month, arrival_day, departure_year, departure_month, departure_day, number_of_rooms)
      @reservations << Reservation.new(client, arrival_year, arrival_month, arrival_day, departure_year, departure_month, departure_day, number_of_rooms)
      rooms_booked = 0
      @list_of_rooms.each do |room|
        if room.booked == false
          room.booked = true
          rooms_booked += 1
          break if rooms_booked == number_of_rooms.to_i
        end
      end
    end
  end
end
