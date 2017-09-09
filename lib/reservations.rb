require_relative 'rooms'
require_relative 'hotel'

module HotelHedwig
  class Reservations
    attr_reader :rooms
    def initialize

    end
  end
end

# Start pseudocode to build

# User Stories Wave 1;

# As an administrator, I can access the list of all of the rooms in the hotel
# As an administrator, I can reserve a room for a given date range
# As an administrator, I can access the list of reservations for a specific date
# As an administrator, I can get the total cost for a given reservation
