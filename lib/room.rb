module Hotel
  class Room
    attr_reader :number, :cost

    def initialize
      @arr_rooms = []
      @cost = 200
    end

    def room_number
      n = 1
      20.times do
        @arr_rooms << n
        n += 1
      end
      return @arr_rooms
    end

  end
end
