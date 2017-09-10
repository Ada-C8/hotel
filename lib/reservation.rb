require_relative 'room'
require_relative 'dates'

module Hotels
  # Contains the information pertinent to Reservations
  class Reservation
    attr_accessor :id, :block_id, :dates, :rooms, :room_count, :total_cost

    def initialize(checkin, checkout = nil, room_count = 1)
      @id = 0
      @block_id = 0
      @dates = []
      Dates.add_dates(@dates, checkin, checkout)
      @rooms = []
      @room_count = room_count
      @total_cost = calc_total
    end

    def calc_total
      nights_charged = @dates.length * @room_count
      block_rate = Hotels::Room::BLOCK_RATE
      regular_rate = Hotels::Room::REGULAR_RATE
      if @block_id.to_i > 0
        @total_cost = block_rate * nights_charged
      else
        @total_cost = regular_rate * nights_charged
      end
    end # changes the value of total cost depending on nightly rate
  end # Reservation class
end # Hotels module
