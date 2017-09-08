module BookingSystem
 class Block

   @@id_count = 1

   attr_reader :date_range, :rooms, :id#, :room_cost

   def initialize(date_range, rooms)
     @id = @@id_count
     @@id_count += 1
     @date_range = date_range
     @rooms = rooms
    #  @room_cost = (Hotel::COST * (1 - Hotel::BLOCK_DISCOUNT / 100.0)).round(2)
    #  @room_cost = room_cost

   end #end of initialize

   def has_available_rooms?
     return @rooms.length > 0
   end #end of method


 end #end of class
end #end of module
