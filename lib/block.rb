require_relative 'booking'
module Hotel
  class Block < Booking
    attr_reader :block_id

    def initialize(id, rooms, date_range, block_id)
      super(id, rooms, date_range)
      @block_id = block_id
      discount
    end

    def discount
      @total_cost -= @total_cost * 0.2
    end

    def rooms_available
      rooms_available = []
      @rooms.each do |room|
        if room.reserved == false
          rooms_available << room
        end
      end
      return rooms_available
    end
  end
end
