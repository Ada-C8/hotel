require 'Booking'
require 'DateRange'
require 'date'

module Hotel
  class Reservations
    attr_reader :room_number

    def initialize
      @all_reservations = []
      @room_number = room_number
      @rooms_collection = []
      all_rooms
      #(1..20).to_a
      #@rooms_collection = []
      # @blocks_arr = []
    end

    def all_rooms
      @rooms_collection = []
      n = 1

      (1..20).each do
        room = Hotel::Room.new(n)
        @rooms_collection << room
        n += 1
      end
      return @rooms_collection
    end

    def all_reservations
      return @all_reservations
    end

    def new_reservation(check_in, check_out, room_number = 0, room_rate = 200)
      booking = Hotel::Booking.new(check_in, check_out, room_number, room_rate)
      auto_assign_room_number(room_number)
      #booking.available?
      @all_reservations << booking
      return booking
    end

    def available?
      return true
      # unless @rooms_collection.include?(room_number)
      #   raise ArgumentError.new("#{room_number} is not a valid room number at this property.")
      # end
      # @dates[0...-1].each do |date|
      #   list_reservations_by_date(date)
      #   @list.each do |booking|
      #     if booking.room_number == room_number
      #       return false
      #     end
      #   end
      # end

    end

    def auto_assign_room_number(room_number)
      unless room_number > 0
        @rooms_collection.each do |room|
          if available?
            room_number = room
          else room_number = nil
          end
        end
        if room_number == nil
          raise ArgumentError.new("No rooms available for those dates.")
        end
      end
    end

    def list_reservations_by_date(date)
      date = Date.parse(date)
      @list = []
      @all_reservations.each do |reservation|
        if date >= reservation.check_in && date < reservation.check_out  #removed = so that it wont' include the check out date
          @list << reservation
        end
      end
      return @list
    end

    def clear_reservations #Using this for testing purposes
      @all_reservations = []
    end

  end
end
