# require_relative '../lib/admin.rb'
# module Hotel
#   class BlockAdmin
#     #def initialize
#     #@rooms =  Hotel::Admin.rooms
#     #@list_reservations = Hotel::Admin.list_reservations
#     #end
#
#     #def can_create_block?
#     #end
#     def can_create_block?(checkin, checkout, number_of_rooms)
#       if number_of_rooms > 5
#         raise ArgumentError.new("There is no possible to create a block qith more of 5 rooms")
#       else
#         if avaliable_rooms_daterange(checkin, checkout).length >= number_of_rooms
#           return true
#         else
#           return false
#         end
#       end
#     end
#
#
#   end#class
# end #module
