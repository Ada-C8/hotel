module Hotel
  class Block

    attr_reader :rooms_in_block, :discount, :check_in, :check_out

    def initialize(check_in, check_out, rooms, name)
      @name = name
      @rooms_in_block =   check_room_validity(rooms)
      @discount = 0.1
      @check_in = check_in
      @check_out = check_out
    end

    private

    def check_room_validity(rooms)
      raise ArgumentError.new "wrong number of rooms " if rooms.length.between?(1, 5) == false
      rooms.each do |room|
        raise ArgumentError.new "room must be a Room object" if room.is_a?(Room) == false
      end
    end

  end  # end of block class
end  # end of Hotel module
