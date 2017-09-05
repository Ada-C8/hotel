module Hotels
  class Hotel

    attr_reader :rooms, :reservations

    def initialize
      @rooms = []
      @reservations = []

      i = 1
      20.times do
        room = Hotels::Room.new(i)
        @rooms << room
        i += 1
      end
    end

  end
end
