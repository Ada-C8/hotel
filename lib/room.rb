module Hotel

  class Room
    attr_reader :per_night, :rooms

    def initialize
      @per_night = 200
      @rooms = {}
      (1..20).each do |room|
        @rooms[room] = @per_night
      end
    end

    def all
      return @rooms
    end

  end #end of Room
end #end of Hotel
