module My_Hotel
  class Block# Makes blocks.

    attr_reader :first_night, :last_night, :room_numbers, :nights_held, :discount, :block_id

    def initialize(nights, array_of_rooms, discount)
      @discount = discount
      @room_numbers = array_of_rooms
      @nights_held = nights
      @block_id = nil
      #@contact_info or payment info could be added as instance variables
    end

    def contain?(date)
        @nights_held.include?(date)
    end

    def create_booking(all_blocks)
      set_block_id
      while unique_block_id?(all_blocks) == false
        set_block_id
      end
    end

    def set_block_id
      new_block_id = ""
      4.times do
        new_block_id = new_block_id + (rand(9)).to_s
      end
      @block_id = new_block_id
    end

    def unique_block_id?(all_blocks)
      if all_blocks.length != 0
        all_blocks.each do |one_block|
          if one_block.block_id == block_id
            return false
          end
        end
      end
      return true
    end
  end
end
