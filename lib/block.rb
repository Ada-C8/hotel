module Hotel
  class Block
    attr_reader :date_range, :block_rooms, :discount, :hotel
    def initialize
      @hotel = Hotel.new
      @block_rooms = []
      @discount = 0.2
    end

    # currently broken/incomplete
    def create_block(rooms,check_in,check_out)
      rooms = []
      # check what rooms are available
      available_for_block = hotel.view_available_rooms(check_in,check_out)
      # push 5 available room onto block_rooms
      # ap "printing available:#{available_for_block}"
      available_for_block.each do |room|
        if rooms.length < 5
          rooms << room
        end
      end
      # rooms.each do |room|
      #   hotel.reserve_room(room_id, check_in, check_out)
      # end
      # ap "printing rooms :#{rooms}"
    end

  end
end
