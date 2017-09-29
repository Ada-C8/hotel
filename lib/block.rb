require_relative 'date_range.rb'

module Hotel
  class Block < DateRange

    attr_reader :check_in, :check_out, :id, :rooms_in_block, :discount

    def initialize(check_in, check_out, id)
      super(check_in, check_out)
      @id = id
      @rooms_in_block = []
    end

    def add_room(room)
      @rooms_in_block << room
    end
  end  # end of block class
end  # end of Hotel module
