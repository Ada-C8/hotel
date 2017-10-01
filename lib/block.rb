module BookingSystem
 class Block

   @@id_count = 1

   attr_reader :date_range, :rooms, :id

   def initialize(date_range, rooms)
     @id = @@id_count
     @@id_count += 1
     @date_range = date_range
     @rooms = rooms #hash

   end #end of initialize

   def has_available_rooms?
     return @rooms.length > 0
   end #end of method

   def reserve_room(room)
     if !has_available_rooms?
       raise NoRoomAvailableError.new("No available rooms in block")
     end
     if !rooms.keys.include?(room)
       raise NoRoomAvailableError.new("Requested room is unavailable")
     end

     @rooms.delete(room)

   end #end of method


 end #end of class
end #end of module
