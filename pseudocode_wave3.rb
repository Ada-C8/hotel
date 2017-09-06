require_relative 'lib/hotel.rb'
require_relative 'lib/room.rb'
require_relative 'lib/reservation.rb'

# Wave 3
# User Stories

# As an administrator, I can create a block of rooms

# => To create a block you need a date range, collection of rooms and a discounted room rate
Hotel::Block.new(begin_date, end_date, num_of_rooms, discount_rate)
# => The collection of rooms should only include rooms that are available for the given date range
Block.rooms.each
# => If a room is set aside in a block, it is not available for reservation by the general public, nor can it be included in another block


# As an administrator, I can check whether a given block has any rooms available

# As an administrator, I can reserve a room from within a block of rooms

#Constraints
# => A block can contain a maximum of 5 rooms
# => When a room is reserved from a block of room, the reservation dates will always match the date range of the block
# => All of the availablility checking logic from Wave 2 should now respect room blocks as well as an individual
