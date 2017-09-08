module Hotel
  class Block

    attr_reader :check_in, :check_out, :id, :rooms_in_block, :discount

    def initialize(check_in, check_out, id)
      @check_in = check_in
      @check_out = check_out
      @id = id
      @discount = 0.1
      @rooms_in_block = []
    end

    def add_room(room)
      @rooms_in_block << room
    end
  end  # end of block class
end  # end of Hotel module
