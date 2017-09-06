module Hotel

  class Room
    attr_reader :room_num, :rate
    attr_accessor :status

    def initialize(room_num, rate, status = :available)
      @room_num = room_num
      @rate = rate
      @status = status
    end

  end #end of Room
end #end of Hotel
