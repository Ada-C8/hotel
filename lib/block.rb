require 'date'

module Hotel
  class Block #< Booking
    attr_reader :id, :dates, :collection_of_rooms, :block_id
    def initialize(checkin, checkout, collection_of_rooms, block_id)
      @dates = DateRange.new(checkin, checkout)
      @collection_of_rooms = collection_of_rooms
      @block_id = block_id
    end

    def total_cost_with_discount
      total_cost = 0
      @collection_of_rooms.each do |room|
        total_cost += room.cost * @dates.total_nights * 0.80
      end
      return total_cost
    end



  end
end
