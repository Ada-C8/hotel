module Hotel
  class Reservation
    require_relative 'date_range'
    # @reservation_id
    attr_reader :total_cost, :dates

    def initialize(room, checkin, checkout)
      @room = room
      checkin = Date.parse(checkin)
      checkout = Date.parse(checkout)
      @dates = DateRange::range_to(checkin, checkout)
      get_total
    end

    def get_total
      num_nights = @dates.length
      # @total_cost = num_nights * @room.cost
    end

    # def includes_dates?(checkin, checkout)
      # Date.parse????
      # dates_to_check = DateRange::range(checkin, checkout)
      # dates_to_check.each do |date|
      # if @dates.include? date
      # return true
    # end
  end
end
