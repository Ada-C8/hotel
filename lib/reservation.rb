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


    def overlap(res_date)  #new addition
      if date_range.date_overlap?(res_date)
        return true
      else
        return false
      end
    end

    def total_cost
      checkin_date = date_range.checkin_date
      checkout_date = date_range.checkout_date

      num_nights = checkout_date - checkin_date

      total_cost = 0
      reserved_rooms.each do |room|
        total_cost += num_nights * room.room_rate
      end

      return total_cost
    end
  end
end
