require_relative 'hotel'
require_relative 'room'

module Hotel
  class Reservation
    @@reservation_id_max = 0
    attr_reader :room_number, :check_in, :check_out, :room, :total_cost, :id
    def initialize(input_room_number, check_in_date, check_out_date)
      @room_number = input_room_number
      # @room = input_room_number
      @room = Hotel.find_room(input_room_number)
      @check_in = Date.new(check_in_date[0], check_in_date[1], check_in_date[2])
      @check_out = Date.new(check_out_date[0], check_out_date[1], check_out_date[2])
      # @total_cost = 0
      @total_cost = cost(@check_in, @check_out)
      @id = generate_id
    end

    def cost(input_check_in, input_check_out)
      length_of_stay = (@check_out - @check_in).to_i
      cost_of_stay = length_of_stay * @room.cost
      return cost_of_stay
    end
    def generate_id
      @@reservation_id_max += 1
      return @@reservation_id_max
    end
  end
end
