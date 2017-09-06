module Hotel
  class HotelClass
    attr_reader :rooms, :reservations
    def initialize
      # access the list of all of the rooms in the hotel
      @rooms = (1..20).to_a
      @reservations = []
    end

    def is_available?(room, date)
      # loop through @rooms
      return true
    end

    def reserve_room
      # reserve a room for a given date range
    end

    def access_reservations
      # access the list of reservations for a specific date
    end

    def get_total
      # get the total cost for a given reservation
    end
  end
end
