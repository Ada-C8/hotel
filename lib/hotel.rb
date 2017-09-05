require_relative 'room'
require_relative 'reservation'

module Hotel
ROOM_NUMBERS = (1..20)

HOTEL_ROOMS = ROOM_NUMBERS.map {|num| Hotel::Room.new(num, 200)}
end
