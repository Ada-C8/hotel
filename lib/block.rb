require 'rooms'
require 'hotel'
require 'reservations'
module Hotels
  class Block
    attr_reader :date_range, :block_of_rooms, :reservations
   def initialize(date_range, block_of_rooms, discount: 100)
     @discount = discount
     @date_range = date_range
     @block_of_rooms = block_of_rooms
     @reservations = 0
   end

   def make_reservation
     if @reservations < @block_of_rooms.length
        @reservations += 1
     end
   end

   def list_unbooked_rooms
     unbooked_rooms = []
     unbooked_rooms = @block_of_rooms[@reservations..-1]
   end








  end
end
