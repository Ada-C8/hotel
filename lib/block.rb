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
    end

    def block_total_cost
      block_total_cost = 0
      @collection_of_rooms_blocked.each do |room|
        block_total_cost += room.cost * @dates.total_nights * 0.80
      end
      return block_total_cost
    end

    def check_block_for_availability(block_id)
      if @collection_of_rooms_blocked == []
        available = false
      else #(implicit @collection_of_rooms_blocked == @how_many_rooms)
        available = true
      end
    end
    ##### later, what if it's not empty or not full?
    # def check_reservations(checkin, checkout)
    #   check_against = DateRange.new(checkin, checkout).night_array
    #   not_available = []
    #   check_against.each do |date|
    #     @all_reservations.each do |booking|
    #       if booking.dates.include?(date)
    #         booking.rooms.each do |room|
    #           not_available << room
    #         end
    #       end
    #     end
    #   end
    #   return not_available
    # end

    def check_block_id(block_id)
      return @block_id == block_id
    end

  end
end
