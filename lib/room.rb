module Hotel

  NUM_OF_ROOMS = 20

  class Room
    attr_reader :available, :cost, :room_number, :booked_dates

    def initialize(room_number)
      @available = true
      # @blocked_off = false #for Wave 3
      @cost = 200
      @room_number = room_number
      @booked_dates = []
    end


    def change_availability(state) # T or F
      # @available ? @available = false : @available = true
      @available = state
    end

    # Returns 20 room objects as an array
    def self.all
      room_array = []
      NUM_OF_ROOMS.times do |i|
        room_array << Hotel::Room.new(i + 1) # Hotel Room Numbers start with 1, not 0
      end
      return room_array
    end


    def available_at?(check_date)
      # because using the ! would return nil if all values were unique
      return !(@booked_dates.include?(check_date))
    end

    def set_booked_dates(admin)
      admin.reservations.each do |reservation|
        (reservation.check_in...reservation.check_out).each do |date|
          @booked_dates << date
        end
      end
      admin.block_reservations.each do |b_reservation|
        (b_reservation.check_in...b_reservation.check_out).each do |date|
          @booked_dates << date
        end
      end
      @booked_dates = @booked_dates.uniq
    end
  end # END OF CLASS

end # END OF MODULE
