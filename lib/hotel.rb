# All buisiness logic here (changed mind from reservations because this makes most sense).

# I need for this to access all of the rooms in the room class.

# I need for this to access all of the reservations, the reservations class holds my dates for the reservations.

# I need for this to provide a total charge amount for the days reserved.

# Somehow I need this to provide reservation list that is DATE specific.  This will be tricky (IMO).

require_relative 'rooms'
require_relative 'reservations'

module HotelHedwig
  class Reservations
    attr_reader :rooms, :check_in, :check_out, :total_charges
    def initialize(rooms, check_in, check_out, total_charges)
      @rooms = rooms
      @check_in = check_in
      @check_out = check_out
      @total_charges = total_charges
    end

    # Start pseudocode
    # Remember to not duplicate methods!

    def all_rooms
      @rooms = []
    end

    def reserve_room(room, check_in, check_out)


    end

    def date_reservations

    end

    # Calculating costs take 3, not sure how to best calculate this or if it belongs here.  The idea is using the base amount aka room_cost (200) multiplied by the number of days customer stays.  Check out day minus check in day provides that number.  I hope. This should also allow for a one day stay ex. 200 * (day 2 - day 1) = 200 * 1 = 200.

    def total_charges
      @room_rate = room_rate * (@check_out - @check_in).to_i
    end
  end
end


# User Stories Wave 1 (methods);

# As an administrator, I can access the list of all of the rooms in the hotel
# As an administrator, I can reserve a room for a given date range
# As an administrator, I can access the list of reservations for a specific date
# As an administrator, I can get the total cost for a given reservation

# Constraints

# The hotel has 20 rooms, and they are numbered 1 through 20
# Every room is identical, and a room always costs $200/night
# The last day of a reservation is the checkout day, so the guest should not be charged for that night
