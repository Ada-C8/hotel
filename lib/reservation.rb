module Hotel
  class Reservation
    attr_reader :id, :date_range
    def initialize(id,room_id,check_in,check_out)
      @id = id
      @date_range = Hotel::DateRange.new(check_in,check_out)
      @room_id = room_id
    end

    def get_total
      # get the total cost for a given reservation
    end
  end
end
