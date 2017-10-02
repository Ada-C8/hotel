require_relative 'lib/hotel.rb'
require_relative 'lib/room.rb'
require_relative 'lib/reservation.rb'

# Wave 1
# User Stories
# => As an administrator, I can access the list of all of the rooms in the hotel
Hotel.rooms # => list of all rooms
[Room1, Room2, Room3, Room4...Room20]
# => As an administrator, I can reserve a room for a given date range
Hotel::Reservation.new(input_room, check_in_date, check_out_date] # => creates instance of a reservation
Hotel::Reservation.new(Room1, 10222017, 10242017)
<Hotel::Reservation @id = 55, @check_in = 10222017, @check_out = 10242017, @length_of_stay = 2, @total_cost = 400>
# => As an administrator, I can access the list of reservations for a specific date
Hotel.find_by_date(input_date)
Hotel::Reservation.find_by_date(10232017) #=> should return my reservation
<Hotel::Reservation @id = 55>
# => As an administrator, I can get the total cost for a given reservation
Hotel.reservation_cost(input_id)
Hotel.find_by_id(input_id).total_cost (?)
# Constraints
# => The hotel has 20 rooms, and they are numbered 1 through 20
# => Every room is identical and a room always costs $200/night
# => The last day of a reservation is the checkoutday, so the guest should not be charged for that night
# => For this wave, any room can be reserved at any time, so you don't need to worry about double booking (-:
#
# Error Handling
# => Your code should raise an error when an invalid date range is provided
