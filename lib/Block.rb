require_relative 'date_range'
module My_Hotel
  class Block

    attr_reader :first_night, :last_night, :room_numbers, :nights_held, :discount, :block_id

    def initialize(nights, array_of_rooms, discount)
      @discount = discount
      @room_numbers = array_of_rooms
      @nights_held = nights
      @block_id = nil
      #@contact_info #could add contact_info
    end

    def set_block_id
      new_block_id = ""
      4.times do
        new_block_id = new_block_id + (rand(9)).to_s
      end
      @block_id = new_block_id
    end
  end
end
