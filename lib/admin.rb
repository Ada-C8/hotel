module Hotel
  class Admin
    attr_reader :list_reservations

    def initialize
      @list_rooms = []
      20.times do |i|
        @list_rooms << i
      end
      @list_reservations = []
    end

    def add_reservation(checkin, checkout)
      newreservation = Hotel::Reservation.new(checkin, checkout)
      @list_reservations << newreservation
    end



  end #class

end #module
