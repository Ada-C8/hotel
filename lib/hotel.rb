module Hotel
  class Hotel
    attr_reader :rooms
    # @reservations

    def initialize(num_rooms)
      @rooms = []
      num_rooms.times do |i|
        @rooms << Room.new(i)
      end
    end
    # #view_avail()
    # #view_booked()
    # #is_available?()
    # #make_reservation()
  end
end
