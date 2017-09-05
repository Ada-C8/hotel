module Hotel
  class Reservation
    @@all_reservations = []

    attr_reader :start_date, :end_date, :room, :total_cost

    def initialize(start_date, end_date, room)
      if end_date > start_date
        @start_date = start_date
        @end_date = end_date
      else
        raise ArgumentError.new "End date is before start date"
      end
      #move to script! Date.valid_date?()
      @room = room
      @number_of_nights = (@end_date - @start_date).to_i
      @total_cost = (200 * @number_of_nights).round(2)
    end

  end
end
