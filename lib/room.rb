module My_Hotel
 BASE_RATE = 200
  class Room

    attr_reader :room_number, :rate

    def initialize(number)
      @room_number = number
      @rate = reset_rate
    end

    # def reset_rate
    #   rate = BASE_RATE
    #   if Reservation.block != 0
    #     rate = BASE_RATE * .75
    #   end
    # end



  end
end
