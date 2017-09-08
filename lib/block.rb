#Notes for how Block will be used in Booking
  #make_block method
    #will make a new instance of a block.
    #It will have a date range, a block ID (that is a sting.upcase), and the number of rooms in the block (maximum of five!).
    #Will check that there are enough availible rooms before making the block.
    #Will add the new instance of Block to the @all_blocks array in Booking.
    #Will only allow unique block_id's to be entered
  # check_block_availibility
      # will check how many rooms are left in the block by iterating though the @all_blocks array to find the block with the right block_id
  # reserve_block_room
      # will reserve a room from within a block
      # it will find the block from within the @all_block array using a block_id
      # First it will check that there are still enough rooms within the block before making the reservation
      # Then it will make a reservation (with a discounted price) and add this reservation to the @all_reservations array.
      # It will delete the room from the block once there is a reservation for that room. 


module Hotel
  class Block
    attr_reader :block_id, :block_rooms, :date_range
    def initialize(block_id, block_rooms, date_range)
      @block_id = block_id.upcase
      @block_rooms = block_rooms
      @date_range = date_range
    end # initialize
  end # Block
end # Hotel
