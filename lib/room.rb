require 'date'

module Hotel
  class Room

    RATE = 200

    attr_reader :room_num, :status, :date_reserved


    def initialize(room_num, status = :open, date_reserved)
      @room_num = room_num
      @status = status
      @date_reserved = Date.new
    end

    def room_numbers(room_num)
      if room_num.between?(1, 20)
        return room_num
      else
        raise ArgumentError.new "Not a valid room number"
      end
    end

    def self.all
      room = Room.new(@room_num, @status, @date_reserved)
      @all_rooms = []
      @all_rooms << room
      return @all_rooms
    end


  end #room
end # module
