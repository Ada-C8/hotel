require_relative 'date_range'
module My_Hotel
  class Reservation

    attr_accessor :reservation_id, :block_id, :room_number, :cost, :nights_booked
    attr_reader :first_night, :last_night


    def initialize(first_night,last_night)
      @first_night = first_night
      @last_night = last_night
      @reservation_id = nil
      @cost = nil
      @room_number = nil
      @nights_booked = My_Hotel::Date_Range.new(first_night,last_night)
      @block_id = nil

    end


  end
end

# h = My_Hotel::Hotel.new
# a = h.make_reservation([2017,1,2], [2017,1,5])
# b = h.make_reservation([2017,2,2], [2017,2,5])
# puts a.reservation_id
# puts b.reservation_id
