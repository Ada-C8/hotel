require 'pry'
require_relative 'reservation'

module Hotel

  class Block #Block of rooms booked for a give time

    attr_reader :block_list, :block_name

    def initialize
      @block_list = []
      @block_name = block_name
    end

    def add(id, day_in, day_out, discount, block_name, room)
      @block_list << Reservation.new(id, day_in, day_out, discount, block_name, room)
    end #add
  end
end
#binding.pry
