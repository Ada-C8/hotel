require 'date'
require 'pry'
module Hotel
  class Reservations

    attr_reader :all_reservations, :all_rooms, :all_blocks

    def initialize
      @all_rooms = []
      create_rooms(@all_rooms)
      @all_reservations = []
      @all_blocks = []
      @all_rooms_in_block = []
    end

    def create_rooms(all_rooms)
      20.times do |i|
        num = i + 1
        all_rooms << Room.new(num)
      end
    end

    def make_booking(checkin, checkout, num_of_rooms = 1)
      # do we have an availability?
      availability = check_availability(checkin, checkout)
      if availability.length < num_of_rooms
        raise ArgumentError.new "Sorry, we don't have enough rooms."
      elsif availability == []
        raise ArgumentError.new "Sorry, there are no rooms available."
      end
      # if hotel has availabilities, Booking.new is created and pushed into @all_reservations
      id = @all_reservations.length
      rooms = availability.take num_of_rooms
      booking = Booking.new(checkin, checkout, rooms, id)
      @all_reservations << booking
      return booking
    end

    def print_reservations
      return @all_reservations
    end

    def check_reservations(checkin, checkout)
      check_against = DateRange.new(checkin, checkout).night_array
      not_available = []
      check_against.each do |date|
        @all_reservations.each do |booking|
          if booking.dates.include?(date)
            booking.rooms.each do |room|
              not_available << room
            end
          end
        end
      end
      return not_available
    end

    def check_availability(checkin, checkout)
      ##### need logic to check for blocks bc then it's not available?
      # this is the inverse of not_available array
      available = []
      @all_rooms.each do |room|
        unless check_reservations(checkin, checkout).include?(room)
          available << room
        end
      end
      return available
    end


    def make_block(checkin, checkout, how_many_rooms, block_id)
      available = check_availability(checkin, checkout)
      if how_many_rooms > 5
        raise ArgumentError.new "You cannot block more than 5 rooms."
      elsif how_many_rooms > available.length
        raise ArgumentError.new "There are only  #{available.length} available for your dates."
      else

        collection_of_rooms_blocked = []
        how_many_rooms.times do |i|
          collection_of_rooms_blocked << available[i]
        end
        new_block = Hotel::Block.new(checkin, checkout, collection_of_rooms_blocked, block_id)
        @all_blocks << new_block
        return new_block
      end
    end

    def reserve_room_from_block(block_id)
      @all_blocks.each do  |block|
        puts "#{block} before block"
        if block.check_block_for_availability(block_id) && block.check_block_id(block_id)
          puts "#{block} middle block"
          rooms = block.available_rooms.take block.how_many_rooms
          rez = Hotel::Block.new(block.dates.checkin, block.dates.checkout, rooms, block.block_id)
          @all_reservations << rez
          return rez
        else
          puts "that block id is not available"
        end
      end
    end
  end
end
