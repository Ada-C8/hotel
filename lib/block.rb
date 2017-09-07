module Property

  class Blocks < Reservation

    attr_reader :rooms, :room_price, :check_in, :check_out

    def initialize
      @rooms = []
      @reserved_blocks = []
      @block_price = block_total
      super(check_in, check_out)
    end



    def block_total
      return ((@check_out - @check_in) * 200 * @rooms.length)
    end

  end
end


make sure to uncomment block in spec helper 
