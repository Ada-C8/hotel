require_relative 'reservation'
require_relative 'room'

module Hotel

  class Block

    MAX_ROOMS = 5

    attr_accessor :check_in, :check_out, :discount, :room_block

    def initialize(check_in, check_out, discount, room_block)
      raise ArgumentError.new("Can't have more than #{MAX_ROOMS} number of rooms in a block") if room_block.length > MAX_ROOMS

      @check_in = check_in
      @check_out = check_out
      @discount = discount
      @room_block = room_block
    end

  end # end of Block class

end
