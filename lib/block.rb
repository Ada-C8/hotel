# block

module HotelManagment
  class block
    attr_reader :amount_of_rooms
    
    BLOCKRATE = 100

    def initialize(amount_of_rooms)
      @amount_of_rooms = amount_of_rooms
    end

  end #class end
end #module end











# require 'awesome_print'
#
# module HotelManagment
#   class Room
#     attr_reader :room_number
#
#     RATE = 200
#
#     def initialize(room_number)
#       @room_number = room_number
#     end
#
#   end #class end
# end #module end
