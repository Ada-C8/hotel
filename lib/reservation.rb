require_relative 'date_range'
module My_Hotel

  class Reservation
    attr_accessor :block_id
    attr_reader :first_night, :last_night, :reservation_id, :room_number, :nights_booked, :cost


    def initialize(first_night, last_night)
      @first_night = first_night
      @last_night = last_night
      @reservation_id = nil
      @cost = nil
      @room_number = nil
      @nights_booked = My_Hotel::Date_Range.new(first_night,last_night)
      @block_id = nil

    end

    def assign_room(rooms_avail)
      if rooms_avail.length != 0
        @room_number = rooms_avail.keys.sample
      else
        raise ArgumentError.new("Can't make reservation, there are no rooms available for those dates: #{@first_night} to #{@last_night}")
      end
    end

    def set_cost
      number_of_nights = @nights_booked.nights.to_a.length
      if number_of_nights <= 0
        return @cost = 0
      else
        cost_per_night = ROOMS[@room_number]
        @cost = number_of_nights * cost_per_night
      end
      @cost
    end

    def set_reservation_id
      new_reservation_id = ""
      6.times do
        new_reservation_id = new_reservation_id + (rand(9)).to_s
      end
      @reservation_id = new_reservation_id
    end

  end
end
# h = My_Hotel::Hotel.new
# a = h.make_reservation([2017,1,2], [2017,1,5])
# b = h.make_reservation([2017,2,2], [2017,2,5])
# puts a.reservation_id
# puts b.reservation_id
