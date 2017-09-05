require_relative 'reservation'

module Hotel

  NUM_ROOMS = 20

  class Room

    DEFAULT_RATE = 200

    attr_reader :room_num
    attr_accessor :rate

    def initialize(room_num, rate = DEFAULT_RATE)

      if valid_room_num?(room_num)
        @room_num = room_num
      else
        raise ArgumentError.new("Not a valid room number")
      end

      @rate = rate
    end

    def self.all
      # create a list of all hotel rooms
      all_rooms = []

      (1..NUM_ROOMS).each do |num|
        all_rooms << Room.new(num)
      end

      return all_rooms
    end

    private

    def valid_room_num?(num)
      return num.class == Integer && num >= 1 && num <= 20
    end

  end # end of Room class

end
