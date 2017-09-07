require 'date'

module Hotel
  class Block

    def initialize(dates, collection_of_rooms, block_id)
      @dates = DateRange.new(checkin, checkout)
      @collection_of_rooms = collection_of_rooms
      @block_id = block_id
    end
    


  end
end
