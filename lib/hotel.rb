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

    # #view_avail()
    # #view_booked()
    # #is_available?()
    # #make_reservation()
  end
end
