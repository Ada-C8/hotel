# All buisiness logic here (changed mind from reservations because this makes most sense).

# I need for this to access all of the rooms in the room class.

# I need for this to access all of the reservations, the reservations class holds my dates for the reservations.

# I need for this to provide a total charge amount for the days reserved.

# Somehow I need this to provide reservation list that is DATE specific.  This will be tricky (IMO).

# require_relative 'rooms'
# require_relative 'reservations'
#
# module HotelHedwig
#   class Reservations
#     attr_reader
#     def initialize
#
#     end

# # Start pseudocode
# Remember to not duplicate methods!

#     def method to access all of the rooms
#
#     end
#
#     def method to reserve a room in a date range.
#
#     end
#
#     def method to access list of reservations for a specific date.
#
#     end
#
#     def method to get total cost for a given reservation.
#
#     end
#   end
# end

# User Stories Wave 1 (methods);

# As an administrator, I can access the list of all of the rooms in the hotel
# As an administrator, I can reserve a room for a given date range
# As an administrator, I can access the list of reservations for a specific date
# As an administrator, I can get the total cost for a given reservation

# Constraints

# The hotel has 20 rooms, and they are numbered 1 through 20
# Every room is identical, and a room always costs $200/night
# The last day of a reservation is the checkout day, so the guest should not be charged for that night
# For this wave, any room can be reserved at any time, and you don't need to check whether reservations conflict with each other (this will come in wave 2!)
