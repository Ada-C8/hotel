module Hotel
  class Reservation
    attr_reader :id, :date_range, :cost_per_night
    def initialize(room_id,check_in,check_out)
      # @id = id
      @date_range = Hotel::DateRange.new(check_in,check_out)
      @room_id = room_id
      @cost_per_night = 200
    end

    def get_total
      # get the total cost for a given reservation
      number_of_nights = date_range.number_of_nights
      total = number_of_nights * cost_per_night
      return total
    end
  end
end
