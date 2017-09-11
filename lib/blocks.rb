module Hotel
  class Blocks
    attr_reader :date_range, :block_rooms, :discount, :hotel
    def initialize
      @hotel = Hotel::HotelClass.new
      @block_rooms = []
      @discount = 0.2
    end

    # currently broken/incomplete
    def create_block(room,check_in,check_out)
      # check what rooms are available
      available_for_block = hotel.view_available_rooms(check_in,check_out)
      # push 5 available room onto block_rooms
      ap "printing available:#{available_for_block}"
      available_for_block.each do |n|
        if block_rooms.length < 5
          block_rooms << n
        end
      end
      ap "printing block_rooms :#{block_rooms}"
    end

  end
end
