require 'pry'
require_relative 'reservation'

module Hotel

  class Block #Block of rooms booked for a give time

      attr_reader :block_list

      def initialize
        @block_list = []
      end

      # def add(id, room, day_in, day_out)
      #   @reservation_list << Reservation.new(id, room, day_in, day_out) #adds Reservation to group
      # end
  end
end



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
