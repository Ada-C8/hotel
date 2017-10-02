require_relative 'lib/hotel.rb'
require_relative 'lib/room.rb'
require_relative 'lib/reservation.rb'

# Wave 2
# User Stories

# => As an administrator, I can view a list of rooms that are not reserved for a given date range
Hotel.available_rooms(begin_date, end_date)
#=> returns array [Room Object.available true for date range]
# => As an administrator, I can reserve an available room for a given date range
Hotel.reserve_room(begin_date, end_date)


# Constraints

# => A reservation is allowed to start on the same day that another reservation for the same room ends


# Error Handling

# => Your code should raise an exception when asked to reserve a room that is not available
