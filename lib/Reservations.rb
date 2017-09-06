module Hotel
  class Reservations
    attr_reader :all_reservations

    @all_reservations = []
    def initialize
    #(1..20).to_a
    #@rooms_collection = []
    # @blocks_arr = []
    end

    def self.all_rooms
      @rooms_collection = []
      n = 1

      (1..20).each do
        room = Hotel::Room.new(n)
        @rooms_collection << room
        n += 1
      end
      return @rooms_collection
    end

    def self.all_reservations
      return @all_reservations
    end

    def self.all_blocks
      @blocks_collection = []
    end

    def new_reservation(check_in, check_out)
      booking = Booking.new(check_in, check_out)
      @all_reservations << booking
    end

  end
end
