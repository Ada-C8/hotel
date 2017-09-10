require 'Booking'
require 'DateRange'
require 'date'
require 'block'

module Hotel
  class Reservations
    attr_reader :room_number
    attr_accessor :blocks_collection

    def initialize
      @all_reservations = []  #pass block reservations into this.
      #@room_number = room_number
      @rooms_collection = []
      all_rooms
      @blocks_collection = []

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
      dates = Hotel::DateRange.new(check_in, check_out).dates
      booking = Hotel::Booking.new(check_in, check_out, room_number, room_rate)
      if check_availability?(dates, room_number) == false
        raise ArgumentError.new("Room number #{room_number} unavailable for those dates.")
        else
          @all_reservations << booking
          return booking
      end
    end


#TESTED and WORKS - need to verify with Block reservatioins but it should work
    def list_rooms_available_by_date(date)
      rooms_available = @rooms_collection
      list_reservations_by_date(date).each do |booking|
        rooms_available.each do |room|
          if room.room_number == booking.room_number
            rooms_available.delete(room)
          end #if end
        end #rooms avail end
      end #list do end
      list_blocked_rooms_by_date(date).each do |block|
        rooms_available.each do |room|
          if room.room_number == block.room_number
            rooms_availale.delete(room)
          end #if end
        end # room avail do end
      end #list do end
      return rooms_available
    end #def end

#TESTED and it WORKS - need to test for Block reservations
    def check_availability?(dates, room_number)
      available = true
      dates[0...-1].each do |date|
        unless available == false
          room_number_array = []
          list_rooms_available_by_date(date).each do |room|
            room_number_array << room.room_number
          end
          if room_number_array.include?(room_number)
            available = true
          else
            available = false
          end
        end
        return available
      end
    end


#MOSTLY TESTED but will need a few more tests most likely
    def new_block(check_in, check_out, block_name, number_of_rooms, block_rooms_collection = [], discounted_room_rate = 180)
      @number_of_rooms = number_of_rooms
      @dates = DateRange.new(check_in, check_out).dates
      create_block_rooms_collection #Method already checks for room availability in order to create collection
      block_rooms_collection = @block_rooms_collection
      block = Hotel::Block.new(check_in, check_out, block_name, @block_rooms_collection, discounted_room_rate = 180)
      @blocks_collection << block
      return block
    end

    def create_block_rooms_collection #TESTED
      unless @number_of_rooms <= 5 && @number_of_rooms >= 1
        raise ArgumentError.new("Blocks can only have between 1 and 5 rooms.")
      end
      rooms_available = @rooms_collection
      @dates.each do |date|
        list_reservations_by_date(date).each do |booking|
          rooms_available.each do |room|
            if room.room_number == booking.room_number
              rooms_available.delete(room)
            end
          end
        end
      end
      @block_rooms_collection = []

      @number_of_rooms.times do |i|
        @block_rooms_collection << rooms_available[i]
      end
      return @block_rooms_collection
    end

    def in_block?(block_name, room_number)
      found = false
      @blocks_collection.each do |block|
        unless found == true
          if block.block_name == block_name
            block.block_rooms_collection.each do |room|
              if room.room_number == room_number
              found = true
              end
            end
          end
        end
      end
      return found
    end

    def new_reservation_in_block(check_in, check_out, block_name, room_number = 0, room_rate = 200)
      block_room_booking = Hotel::Booking.new(check_in, check_out, room_number, room_rate)
      #block_room.has_rooms_available?   #need error message if not
      # unless in_block?(block_name, room_number) == true
      #   return ArgumentError.new("Room number #{room_number} not included in #{block_name} block.")
      # end

      #room_number = block_room.available_rooms.pop!
      #not sure about above... can't I just compare booked rooms with rooms collection?
      #Be sure to add to booked rooms list once booked and all reservations
      @all_reservations << block_room_booking  # TEST that it doesn't go in if not a valid booking
      return block_room_booking
    end

#I don't think I"ll need this but keep for now and hasn't been tested#
    # def assign_block_room(check_in, check_out, room_number)
    #   date_range = DateRange.new(check_in, check_out).dates
        # block_name.
    #   date_range[0...-1].each do |date|
    #     list_reservations_by_date(date).each do |booking|
    #       if booking.room_number == room_number
    #         raise ArgumentError.new("Room number #{room_number} is not available for those dates.")
    #       end
    #     end
    #   end
    # end

#I moved this function under the block class - delete later
    # def block_check_room_available(room_number, dates)
    #     list_reservations_by_date
    # end

#Not required and not yet incorporated nor tested
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

#Not required and not yet incorporated nor tested
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

    def list_reservations_by_date(date) #TESTED
      date = Date.parse(date)
      list = []
      @all_reservations.each do |reservation|
        if date >= reservation.check_in && date < reservation.check_out  #check_out date excluded
          list << reservation
        end
      end
      return list
    end

    def list_blocked_rooms_by_date(date)  #TESTED
      date = Date.parse(date)
      blocks_list = []
      @blocks_collection.each do |block|
        if date >= block.dates[0] && date < block.dates[-1]
          block.block_rooms_collection.each do |room|
            blocks_list << room
          end
        end
      end
      return blocks_list
    end

    def clear_reservations #Using this for testing purposes
      @all_reservations = []
    end

  end
end
