
module My_Hotel

  class Reservation # Makes reservations.
    attr_accessor :block_id
    attr_reader :reservation_id, :room_number, :nights_booked, :cost


    def initialize(nights)
      @reservation_id = nil
      @cost = nil
      @room_number = nil
      @nights_booked = nights
      @block_id = nil
      #@contact_info or payment info could be added as instance variables
    end

    def create_booking(all_reservations, rooms_avail, discount=1, block_id=nil)
      assign_room(rooms_avail)
      set_cost(discount)
      set_reservation_id
      @block_id = block_id
      while unique_reservation_id?(all_reservations) == false
        set_reservation_id
      end
    end

    def assign_room(rooms_avail)
      if rooms_avail.length != 0
        @room_number = rooms_avail.keys.sample
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

    def unique_reservation_id?(all_reservations)
      if all_reservations.length != 0
        all_reservations.each do |one_reservation|
          if one_reservation.reservation_id == @reservation_id
            return false
          end
        end
      end
      return true
    end

  end
end
