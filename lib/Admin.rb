module Hotel
  class Admin

    attr_reader :room_num

    def initialize
      @reservations = Hotel::Reservation.reservation_array
      @room_num = []
      20.times do |i|
        @room_num << (i + 1)
      end
    end

    # def
    #
    # end

  end
end
