require 'date'

module Hotel
  NUM_OF_ROOMS = 20
  class Room
    attr_reader :available, :check_in_date, :check_out_date, :cost

    def initialize
      @available = true
      # @blocked_off = false #for Wave 3
      @check_in_date = nil
      @check_out_date = nil
      @cost = 200
    end

    def self.all
      room_hash = {}
      NUM_OF_ROOMS.times do |i|
        current_room_hash = {i+1 => Hotel::Room.new} # Hotel Room Numbers start with 1, not 0
        room_hash.merge!(current_room_hash)
      end
      return room_hash
    end

    def change_availability
      @available ? @available = false : @available = true
    end

  end
end
