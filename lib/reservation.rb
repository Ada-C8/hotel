module Hotel
  class Reservation
    attr_reader :name, :reserved_rooms, :date_range

    def initialize(name, reserved_rooms, date_range)
      @name = name
      @reserved_rooms = reserved_rooms
      @date_range = date_range
      # puts @reserved_rooms # test if list of all rooms is printing
      # puts @name
      # puts @date_range
    end

    def total_cost
      num_nights = checkout_date - checkin_date
      total_cost  = num_nights * room_rate
      return total_cost
    end








  end

end
