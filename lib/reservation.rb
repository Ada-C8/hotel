module Hotel
  class Reservation
    attr_reader :check_in_date, :check_out_date

    def initialize(check_in, check_out, room_num, admin)
      if check_out < check_in
        return nil
      elsif room_num > NUM_OF_ROOMS || room_num < NUM_OF_ROOMS
        return nil
      end
      @check_in = check_in_date
      @check_out = check_out_date
      @room = admin.find_room(room_num)
      @room.change_availability
    end

  end
end
