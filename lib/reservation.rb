require_relative 'date_range'
module My_Hotel

  class Reservation
    attr_accessor :block_id
    attr_reader :first_night, :last_night, :reservation_id, :room_number, :nights_booked, :cost


    def initialize(nights)
      @reservation_id = nil
      @cost = nil
      @room_number = nil
      @nights_booked = nights
      @block_id = nil
      #@contact_info #could add contact_info
    end

    def assign_room(rooms_avail)
      if rooms_avail.length != 0
        @room_number = rooms_avail.keys.sample
      else
        raise ArgumentError.new("Can't make reservation, there are no rooms available for those dates: #{@nights_booked}")
      end
    end

    #enter discount as a decimal
    def set_cost(discount=1)
      number_of_nights = @nights_booked.to_a.length
      cost_per_night = ROOMS[@room_number]
      @cost = number_of_nights * cost_per_night * discount
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
