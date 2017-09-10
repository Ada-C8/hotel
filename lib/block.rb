require_relative 'reservation'
require_relative 'room'
require_relative 'reservable'

module Hotel

  class Block
    include Reservable

    @@all_blocks = []

    MAX_ROOMS = 5

    attr_accessor :check_in, :check_out, :discount, :room_block, :block_id

    def initialize(check_in, check_out, discount, room_block)
      # check input
      valid_dates?(check_in, check_out)
      valid_room_block?(room_block, check_in, check_out)
      valid_discount?(discount)

      @block_id = @@all_blocks.length + 1
      @check_in = check_in
      @check_out = check_out

      @discount = discount  # discount as decimal (e.g. 0.8 for 80% of orig rate)
      @room_block = room_block # array of rooms

      # add block to each room
      room_block.cycle(1) { |room| room.blocks << self }

      @@all_blocks << self

    end

    def room_available?(room)
      raise ArgumentError.new("Room #{room.room_num} isn't in the block") if !room_block.include?(room)

      return !room.booked?(check_in, check_out)
    end

    def find_avail_in_block
      return room_block.select { |room| room_available?(room) }
    end

    def reserve(room)
      raise ArgumentError.new("Room #{room.room_num} isn't in the block") if !room_block.include?(room)

      raise ArgumentError.new("Room #{room.room_num} isn't available for the selected dates") if room.booked?(check_in, check_out)

      return room.reserve(check_in, check_out)
    end

    def discounted_cost(room)
      rate = room.rate * discount
      return total_cost(rate)
    end

    def self.all
      return @@all_blocks
    end

    def self.clear
      @@all_blocks = []
    end

    def self.find(block_id)
      blocks = self.all

      blocks.each do |block|
        if block.block_id == block_id
          return block
        end
      end

      return nil
    end

  end # end of Block class

end
