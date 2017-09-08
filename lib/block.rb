
module Hotel_System
  class Block < Hotel_System::Reservation
    attr_accessor :check_in, :check_out, :rooms, :rate_adjustor, :rooms_reserved_in_block

    def initialize(check_in, check_out, rooms, rate_adjustor)
      @check_in = check_in
      @check_out = check_out
      @rooms = rooms
      @rate_adjustor = rate_adjustor
      @rooms_reserved_in_block = []
    end

    def reserve_in_block
      if self.rooms == []
        raise StandardError.new("All of the rooms in this block are already reserved")
      end
        @rooms_reserved_in_block << @rooms.pop
    end

    def find_avail_rooms
      @rooms.reject {|room| @rooms_reserved_in_block.include?(room)}
    end
  end
end
