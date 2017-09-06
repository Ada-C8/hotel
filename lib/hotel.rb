module Hotel
  class HotelClass
    attr_reader :rooms, :reservations
    def initialize
      # access the list of all of the rooms in the hotel
      @rooms = []
      @reservations = []
    end

    def reserve_rooms
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
