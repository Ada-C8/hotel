require_relative 'hotel'

module ReservationSystem
  class Block
    include Reservable
    attr_reader :rooms, :block_rate, :start_date, :nights, :dates_blocked

    def initialize(start_date, nights, rooms_list, block_rate)
      @rooms = rooms_list
      @start_date = start_date
      @nights = nights
      @dates_blocked = date_range(start_date, nights)
      @block_rate = block_rate

      @rooms.each do |room|
        room.blocked_nights += @dates_blocked
        room.rate = block_rate
      end
    end # initialize

  end #Block class
end #module
