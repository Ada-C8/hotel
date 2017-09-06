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




  end
end
