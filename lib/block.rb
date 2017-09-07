module BookingSystem
 class Block

   DISCOUNT = 0.9
   @@id_count = 1

   attr_reader :date_range, :rooms, :id, :room_cost

   def initialize(date_range, rooms)
     @id = @@id_count
     @@id_count += 1
     @date_range = date_range
     @rooms = rooms
     @room_cost = (Reservation::COST * DISCOUNT).to_i

   end #end of initialize

   def has_available_rooms?
     return @rooms.length > 0
   end #end of method


 end #end of class
end #end of module
