module Hotel
  class HotelClass
    attr_reader :rooms, :reservations
    def initialize
      @rooms = []
      @reservations = []
    end
  end
end
