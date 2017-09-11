# Room logic.
# 20 rooms numbered 1 - 20.
# Each room is $200

module HotelHedwig
  class Rooms

    attr_reader :room_num, :room_cost

    def initialize(room_num)
      @room_num = room_num
      @room_cost = 200
    end
  end
end
