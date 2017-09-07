require_relative '../lib/hotel.rb'
require_relative '../lib/room.rb'
require_relative '../lib/reservations.rb'

hotel = Hotel_System::Hotel.new(20)

# puts hotel.return_room_object_by_num(19).room_number

reservation = Hotel_System::Reservations.new(1, "2018-1-1", "2018-1-5", @hotel)
reservation2 = Hotel_System::Reservations.new(1, "2017-12-25", "2018-1-4", @hotel)

# p @hotel2.reservations_by_date("2018-1-1")


# @hotel2.reservations_by_date("2017-12-26").length.must_equal 1
