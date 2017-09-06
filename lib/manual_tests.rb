require_relative '../lib/hotel.rb'
require_relative '../lib/room.rb'
require_relative '../lib/reservations.rb'

hotel = Hotel_System::Hotel.new(20)

puts hotel.return_room_object_by_num(19).room_number

p hotel.list_of_rooms
