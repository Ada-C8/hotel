module Hotel
  class Reservations
    attr_reader :rooms_collection, :reservations_collection, :blocks_collection


    def initialize
    #(1..20).to_a
    #@rooms_collection = []
    # @reservations_arr = []
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
      @reservations_collection = []

    end

    def self.all_blocks
      @blocks_collection = []
    end


  end
end
