module Hotel
  class Reservation
    attr_reader :date_range, :room_id, :cost_per_night
    def initialize(room_id,check_in,check_out)
      # @id = id
      @date_range = DateRange.new(check_in,check_out)
      @room_id = room_id
      @cost_per_night = 200
    end

    def get_total
      # get the total cost for a given reservation
      # number_of_nights = date_range.number_of_nights
      # total = number_of_nights * cost_per_night
      # return total

      # using an instance method from DateRange instead of an instance variable to come up with the total 
      return date_range.number_of_nights * @cost_per_night
    end
  end
end
