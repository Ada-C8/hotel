module BookingSystem
  class Hotel
    attr_reader :rooms, :all_reservations
    def initialize
      @rooms = (1..20).to_a
      @all_reservations = []
    end



  end
end
