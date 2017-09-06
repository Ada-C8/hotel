module Hotel
  class Hotel
    attr_reader :rooms, :reservations

    def initialize(num_rooms)
      @rooms = []
      num_rooms.times do |i|
        @rooms << Room.new(i+1)
      end
      @reservations = []
    end

    def all_rooms
      list = []
      @rooms.each { |room| list << room.number }
      list
    end

    def make_reservation(checkin, checkout)
      @reservations << Reservation.new(checkin, checkout)
    end

    # def view_avail(checkin, checkout)
    #   available_rooms = []
    #   @rooms.each do |room|
    #     available_rooms << room.number if room.is_avail?(checkin, checkout)
    #     available_rooms
    #   end
    # end

    # def view_reservations(date)
    #   reservations = []
    #   @reservations.each do |reservation|
    #     reservations << reservation if reservation.dates.include?(date)
    #   end
    #   reservations
    # end

    # def find_available_rooms(checkin, checkout)
    #   booked_rooms, available_rooms = [], []
    #   @reservations.each do |reservation|
    #     if reservation.room is not in booked_room && !(reservation.includes_dates?(checkin,checkout))
    #       booked_rooms << reservation.number
    #     end
    #   end
    #   @rooms.each do |room|
    #     available_rooms << room unless booked_rooms.include?room.number
    #   end
    #   available_rooms
    # end


    # def make_reservation(checkin, checkout)
    #   room_num = find_available_rooms(checkin, checkout).first
    #   @reservations << Reservation.new(room_num, checkin, checkout)
    # end

  end
end
