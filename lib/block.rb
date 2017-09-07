module BookingSystem
 class Block

   COST = 200
   DISCOUNT = 0.9
   @@id_count = 1

   attr_reader :date_range, :rooms, :id, :block_cost

   def initialize(date_range, rooms)
     @id = @@id_count
     @@id_count += 1
     @date_range = date_range
     @rooms = rooms
     @block_cost = (COST * DISCOUNT * date_range.dates_within_range.length * rooms.length).to_i

   end #end of initialize


 end #end of class
end #end of module
