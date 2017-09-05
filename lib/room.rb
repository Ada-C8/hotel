#Room.rb
require 'awesome_print'

module Hotel
  class Room

  attr_reader :room_id, :rate

  def initialize(room_id, rate = @std_rate)
    @room_id = room_id
    @std_rate = $200
    @NO_OF_ROOMS = 20
  end

  #Returns a list of all rooms in the hotel
  def self.all
    rooms_array = []
    @NO_OF_ROOMS.times do |room|
      rooms_array << Hotel::Room.new(room+1)
    end
    return rooms_array
  end

  end
end
