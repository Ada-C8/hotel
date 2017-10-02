require 'Booking'
require 'DateRange'
require 'date'
require 'block'

module Hotel
  class Reservations
    attr_reader :all_reservations, :rooms_collection
    attr_accessor :blocks_collection

    def initialize
      @all_reservations = []
      @rooms_collection = []
      all_rooms
      @blocks_collection = []
      # @booking = Hotel::Booking.new(check_in, check_out, room_number, room_rate)
      # @block = Hotel::Block.new(check_in, check_out, block_name, @block_rooms_collection, discounted_room_rate = 180)
      # @dates = @date_range.dates
    end

    def all_rooms
      if @rooms_collection.empty? == false
        return @rooms_collection
      end

      n = 1

      (1..20).each do
        room = Hotel::Room.new(n)
        @rooms_collection << room
        n += 1
      end
      return @rooms_collection
    end


    def new_reservation(check_in, check_out, room_number = rand(1..20), room_rate = 200)
      booking = Hotel::Booking.new(check_in, check_out, room_number, room_rate)
      dates = booking.dates
      if check_availability?(dates, room_number) == false
        raise ArgumentError.new("Room number #{room_number} unavailable for those dates.")
      else
        @all_reservations << booking
        return booking
      end
    end

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

    def new_block(check_in, check_out, block_name, number_of_rooms, block_rooms_collection = [], discounted_room_rate = 180)
      @number_of_rooms = number_of_rooms
      @dates = DateRange.new(check_in, check_out).dates
      create_block_rooms_collection #Method already checks for room availability in order to create collection
      block_rooms_collection = @block_rooms_collection
      block = Hotel::Block.new(check_in, check_out, block_name, @block_rooms_collection, discounted_room_rate = 180)
      # @dates = @date_range.dates
      @blocks_collection << block
      return block
    end

    def create_block_rooms_collection
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

    def check_in_block(block, room_number)
          block.block_rooms_collection.each do |room|
            if room.room_number == room_number
              return true
            end
          end
      raise ArgumentError.new("Room number #{room_number} not included in #{block.block_name} block.")
    end

    def new_reservation_in_block(check_in, check_out, block_name, room_number = 0, room_rate = 180)
      block_room_booking = Hotel::Booking.new(check_in, check_out, room_number, room_rate)
      check_in = Date.parse(check_in)
      check_out = Date.parse(check_out)
      block = match_block(block_name)
      block.validate_block_dates(check_in, check_out, block)
      check_in_block(block, room_number)
      check_block_room_available(block, room_number)


      add_block_booking_to_block(block, block_room_booking)

      @all_reservations << block_room_booking
      return block_room_booking
    end

    def match_block(block_name)
      this_block = nil
      @blocks_collection.each do |block|
        if block.block_name == block_name
          this_block = block
        end
      end

      if this_block == nil
        raise ArgumentError("Block #{block_name} does not exist.")
      else
      return this_block
      end

    end


    def add_block_booking_to_block(block, block_room_booking)
      block.booked << block_room_booking
    end

    def check_block_room_available(block, room_number)
          block.booked.each do |booking|
            if booking.room_number == room_number
              raise ArgumentError.new("Unable to book. Room number #{room_number} has already been booked.")
            end
          end
      return true
    end

    def list_reservations_by_date(date)
      if date.class != Date
        date = Date.parse(date)
      end
      list = []
      @all_reservations.each do |reservation|
        if date >= reservation.check_in && date < reservation.check_out
          #reservation.overlaps?(date)  #check_out date excluded
          list << reservation
        end
      end
      return list
    end

    def list_blocked_rooms_by_date(date)
      if date.class != Date
        date = Date.parse(date)
      end

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
