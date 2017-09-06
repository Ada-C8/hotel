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

    # def self.all_blocks
    #   @blocks_collection = []
    # end

    def self.new_reservation(check_in, check_out, room_number = rand(1..20), room_rate = 200, total_cost = 200)
      booking = Hotel::Booking.new(check_in, check_out)
      @all_reservations << booking
      return booking
    end

    def list_reservations_by_date
    end

    def self.clear_reservations #Using this for testing purposes
      @all_reservations = []
    end

  end
end
