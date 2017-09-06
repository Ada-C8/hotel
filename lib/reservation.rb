module Hotel
  class Reservation
    require_relative 'date_range'
    # @reservation_id
    attr_reader :total_cost, :dates, :checkin, :checkout, :id, :hotel

    def initialize(room, checkin, checkout, hotel)
      @room = room
      @checkin = Date.parse(checkin)
      @checkout = Date.parse(checkout)
      @dates = DateRange::range_to(@checkin, @checkout)
      @id = create_id
      @hotel = hotel
      get_total
    end

    def get_total
      num_nights = @dates.length
      @total_cost = @hotel.room(@room).cost * num_nights
    end

    # def includes_dates?(checkin, checkout)
    # Date.parse????
    # dates_to_check = DateRange::range(checkin, checkout)
    # dates_to_check.each do |date|
    # if @dates.include? date
    # return true
    # end

    private

    def create_id
      '%.2d%.2d%.4d' % [@checkin.month, @checkin.day, rand(9999)]
    end

  end
end
