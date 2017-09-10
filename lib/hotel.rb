# All buisiness logic here (changed mind from reservations)

require_relative 'rooms'
require_relative 'hotel'

module HotelHedwig
  class Reservations
    attr_reader :rooms
    def initialize

    end
# Start pseudocode to build Wave 1
    def method to access all of the rooms

    end

    def method to reserve a room in a date range.

    end

    def method to access list of reservations for a specific date.

    end

    def method to get total cost for a given reservation.

    end
  end
end

# User Stories Wave 1;

# As an administrator, I can access the list of all of the rooms in the hotel
# As an administrator, I can reserve a room for a given date range
# As an administrator, I can access the list of reservations for a specific date
# As an administrator, I can get the total cost for a given reservation

# Constraints

# The hotel has 20 rooms, and they are numbered 1 through 20
# Every room is identical, and a room always costs $200/night
# The last day of a reservation is the checkout day, so the guest should not be charged for that night
# For this wave, any room can be reserved at any time, and you don't need to check whether reservations conflict with each other (this will come in wave 2!)
