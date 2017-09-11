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

#establish a block and put a hold on reservations for anyone without the code

# As an administrator, I can create a block of rooms


# To create a block you need a date range, collection of rooms and a discounted room rate


# The collection of rooms should only include rooms that are available for the given date range


# If a room is set aside in a block, it is not available for reservation by the general public, nor can it be included in another block


# As an administrator, I can check whether a given block has any rooms available
# As an administrator, I can reserve a room from within a block of rooms
#
#
# A block can contain a maximum of 5 rooms
# When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
# All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations
