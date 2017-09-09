require 'date'

module Hotel
  class Block # << Room do I want to do this?
    attr_reader :id, :dates, :block_id, :available_rooms, :how_many_rooms

    def initialize(checkin, checkout, collection_of_rooms_blocked, block_id)
      @dates = DateRange.new(checkin, checkout)
      @collection_of_rooms_blocked = collection_of_rooms_blocked
      @how_many_rooms = collection_of_rooms_blocked.length
      @block_id = block_id
      @available_rooms = collection_of_rooms_blocked

      #  @available_rooms.length.times do |i|
      # #   @collection_of_rooms << false
      #  or  @all_rooms << false
      #  end
    end

    def block_total_cost
      block_total_cost = 0
      @collection_of_rooms_blocked.each do |room|
        block_total_cost += room.cost * @dates.total_nights * 0.80
      end
      return block_total_cost
    end

    def check_block_for_availability(block_id)
      # @all_blocks.each do |block|
      if @collection_of_rooms_blocked == []
        available = false
      else @collection_of_rooms_blocked == @how_many_rooms
        available = true
      end
    end
    ##### later, if it's not empty or not full, I NEED MORE LOGIC

    def check_block_id(block_id)
      return @block_id == block_id
    end

  end
end
