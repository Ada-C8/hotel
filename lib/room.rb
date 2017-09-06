require 'date'

module Hotel

  NUM_OF_ROOMS = 20

  class Room
    attr_reader :available, :check_in_date, :check_out_date, :cost, :id

    def initialize(room_number)
      @available = true
      # @blocked_off = false #for Wave 3
      @check_in_date = nil
      @check_out_date = nil
      @cost = 200
      @room_number = room_number
    end

    def self.create_rooms
      room_array = []
      NUM_OF_ROOMS.times do |i|
        room_array << Hotel::Room.new(i + 1) # Hotel Room Numbers start with 1, not 0
      end
      return room_array
    end

    def change_availability
      @available ? @available = false : @available = true
    end

  end
end
