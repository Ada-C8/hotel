require 'date'

module Hotel
  class Block # << Room do I want to do this?
    attr_reader :id, :dates, :collection_of_rooms_blocked, :block_id, :available_rooms, :how_many_rooms, :block_total_cost

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
    # delete @all_blocks?
    ##### need to think about self down below :

    def check_block_id(block_id)
      return @block_id == block_id
    end


    # if @collection_of_rooms_blocked == []
    #   raise ArgumentError.new "No room blocks exist yet"
    # else
    #   @collection_of_rooms_blocked.each do |room|
    #     if block_id == @block_id
    #
    #
    #       if room.available.include?(true) #wait or false?
    #         index = 0
    #         block.collection_of_rooms_blocked.each do |get_a_room|
    #           if get_a_room[index] == false
    #             checkin = new_block
    #             checkout = new_block
    #             # rooms = how_many_rooms ###figure out
    #             # block_id = # string? or block.available[index].number
    #             new_rez = Booking.new(checkin, checkout, rooms, block_id)
    #             #(checkin, checkout, collection_of_rooms_blocked, block_id)
    #
    #             @collection_of_rooms_blocked << new_rez
    #             @all_reservations << new_rez
    #             get_a_room == true
    #           end
    #         end
    #       else
    #         puts "There are no rooms avaiable for this block"
    #       end
    #     end
    #   end
  end
end
