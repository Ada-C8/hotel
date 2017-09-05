require_relative 'room.rb'

module Hotel_System

class Hotel

  attr_reader :all_rooms

  def initialize(num_of_rooms)
    @all_rooms = fill_hotel(num_of_rooms)
  end


private

  def fill_hotel(num_of_rooms)
    room_array = []
    num_of_rooms.times do |i|
      room_array << Room.new(i + 1, 200)
    end
    return room_array
  end

end

end
