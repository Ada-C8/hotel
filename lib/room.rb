require_relative 'reservation'

module Hotel

  # NUM_ROOMS = 20

  class Room

    DEFAULT_RATE = 200

    attr_reader :room_num, :reservations
    attr_accessor :rate

    def initialize(room_num, rate = DEFAULT_RATE)

      if room_num > 0
        @room_num = room_num
      else
        raise ArgumentError.new("Not a valid room number")
      end

      @reservations = []
      @rate = rate
    end

    # def self.all
    #   # create a list of all hotel rooms
    #   all_rooms = []
    #
    #   (1..Hotel::NUM_ROOMS).each do |num|
    #     all_rooms << Room.new(num)
    #   end
    #
    #   return all_rooms
    # end

    def reserve(start_date, end_date)
      # add reservation if room is available and return true; else false
      #if is_available
      if !is_booked?(start_date, end_date)
        reservations << ::Hotel::Reservation.new(start_date, end_date, room_num)
        return true
      end

      return false
    end

    def is_booked?(start_date, end_date = start_date.next_day)
      # don't include final date since check-out doesn't conflict with check-in of a new reservation
      date_range = (start_date...end_date).to_a

      reservations.each do |reservation|
        date_range.each do |date|
          if reservation.include?(date)
            return true
          end
        end
      end

      return false

      # reservations.each do |reservation|
      #   if reservation.include?(date)
      #     return true
      #   end
      # end
      #
      # return false
    end

    private

    # def valid_room_num?(num)
    #   return num >= 1 && num <= ::Hotel::Hotel::NUM_ROOMS
    # end

    # def is_available?(start_date, end_date)
    #   @reservations.each do |reservation|
    #     check_in = reservation.check_in
    #     check_out = reservation.check_out
    #
    #     if date >= check_in && date < check_out
    #       return false
    #     end
    #   end
    #
    #   return true
    # end

  end # end of Room class

end
