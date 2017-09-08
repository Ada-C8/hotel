require_relative 'reservation'

module Hotel

  class Room
    attr_reader :room_num, :rate, :dates
    attr_accessor :reservations

    def initialize(room_num, rate)
      @room_num = room_num
      @rate = rate
      @reservations = []
    end

    def create_reservation(start_date, end_date)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      dates = (start_date..end_date).map(&:to_s)
      reservation = Hotel::Reservation.new(start_date, end_date)

      if @reservations.length == 0
        @reservations << reservation
      else
        @reservations.each do |item|
          compare = dates & item.dates # add a .pop type thing
          if compare.length != 0
            raise ArguementError("This room is already booked.")
          end
        end
        @reservations << reservation
      end
    end

  end #end of Room
end #end of Hotel
