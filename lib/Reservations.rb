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

    def new_reservation(check_in, check_out, room_number = rand(1..20), room_rate = 200)
      booking = Hotel::Booking.new(check_in, check_out, room_number, room_rate)
      #validate_room_number
      #booking.assign_room_number
      available(check_in, check_out, room_number)
      @all_reservations << booking
      return booking
    end

    def available(check_in, check_out, room_number)
      date_range = DateRange.new(check_in, check_out).dates
        date_range[0...-1].each do |date|
          list_reservations_by_date(date).each do |booking|
            if booking.room_number == room_number
              raise ArgumentError.new("Room number #{room_number} is not available for those dates.")
            end
          end
        end
    end

    def list_rooms_available_by_date(date)
      rooms_available = @rooms_collection


      # list_reservations_by_date(date).each do |booking|
      #   i = 0
      #   rooms_available.length.times do
      #     if booking.room_number == rooms_available[i].room_number
      #       rooms_available.delete_at(i)
      #     end
      #     i += 1
      #   end
      # end
      list_reservations_by_date(date).each do |booking|
          #room_number = booking.room_number
        rooms_available.each do |room|
          if room.room_number == booking.room_number
            rooms_available.delete(room)
          end
        end
      end
      return rooms_available
    end

    # def validate_room_number   #THIS DOESN"T WORK YET
    #   validation = false
    #   @rooms_collection.each do |room|
    #     unless validation == true
    #       if room.room_number == @room_number
    #         validation = true
    #       else validation = false
    #       end
    #     end
    #   end
    #   if validation == false
    #     raise ArgumentError.new("#{room_number} is not a valid room number at this property.")
    #     return false
    #   else
    #     return true
    #   end
    # end


    #THIS DIDN"T WORK#
      # @dates[0...-1].each do |date|
      #   list_reservations_by_date(date)
      #   @list.each do |booking|
      #     if booking.room_number == room_number
      #       return false
      #     end
      #   end
      # end

    #end

    # def assign_room_number  #DOESN"T WORK YET
    #   unless @room_number > 0
    #     @rooms_collection.each do |room|
    #       if available?
    #         @room_number = room.room_number
    #         return @room_number
    #       else @room_number = nil
    #       end
    #     end
    #     if @room_number == nil
    #       raise ArgumentError.new("No rooms available for those dates.")
    #     end
    #   end
    #     #room_number = @rooms_collection
    #   #end
    # end

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
