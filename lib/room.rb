module Hotel
  class Room
    attr_reader :number, :cost

    def initialize(number)
      @number = number
      @cost = 200
    end



  end
end



# require 'date'
#
# module Hotel
#   class Room
#     attr_reader :cost, :arr_rooms # :room_number
#
#
#     def initialize
#       @arr_rooms = []
#       @cost = 200
#       room_number
#     end
#
#     def room_number
#       n = 1
#       20.times do
#         @arr_rooms << n
#         n += 1
#       end
#       return @arr_rooms
#     end
#
#   end
# end
