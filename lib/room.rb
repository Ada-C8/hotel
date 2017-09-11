require 'date'
require 'csv'
require_relative 'invalid_room_error'

module Hotel
  class Room
    attr_reader :room_number, :rooms_available

    def initialize(room_number)
      @room_number = room_number
    end # end #initialize

    def self.all
      all_rooms = []
      CSV.open("support/rooms.csv", 'r').each do |line|
        room_number = line[0].to_i
        all_rooms << self.new(room_number)
      end
      return all_rooms
    end # end #self.all

    def self.find(room_number)
      self.all.each do |room|
        if room_number == room.room_number
          return room
        end
      end
      raise InvalidRoomError.new ('Invalid Room Number')
    end # end #self.find
  end # end Room class
end # Hotel module
