require_relative 'reservation'
require_relative 'block'
require_relative 'range'
require 'date'

module Property

  class Hotel

    attr_reader :reservations, :rooms, :room_price

    def initialize
      @rooms = (1..20).to_a
      @room_price = 200
      @reservations = []
      @reserved_blocks = []
    end

    def list_reservations(dates)
      @reservations.select { |rez| rez.contains(dates) }
    end


    def available(check_in, check_out)
      dates = Range.new(check_in, check_out)
      available = @rooms

      overlap_blocks = @reserved_blocks.select do |block|
        block.overlap?(dates)
      end
      blocked_rooms = overlap_blocks.reduce([]) do |memo, block|
        memo += block.rooms
      end
      available -= blocked_rooms

      overlap = @reservations.select do |rez|
        rez.overlap?(dates)
      end
      already_reserved = overlap.map do |rez|
        rez.room
      end
      available -= already_reserved
      return available
    end


    def reserve_room(room, check_in, check_out)
      raise ArgumentError.new "Room unavailable." unless @rooms.include? room
      raise ArgumentError.new "Room #{room}is booked between
      # #{check_in} and #{check_out}" unless available(check_in, check_out).include? room

      room_rez = Reservation.new(room, check_in, check_out, @room_price)
      @reservations << room_rez

      return room_rez
    end


    def hotel_block(room_qty, check_in, check_out, price)
      rooms = available(check_in, check_out)

      raise ArgumentError "Insufficient room availability" if rooms.length < room_qty

      block = Property::Block.new(rooms.first(room_qty), check_in, check_out, price)
      rooms = available(check_in, check_out)

      if rooms.length < room_qty
        raise ArgumentError("Not enough rooms available")
      end

      @reserved_blocks << block
      return block
    end


    def reserve_from_block(block)
      room = block.reserve_room
      room_rez = Reservation.new(room, block.check_in, block.check_out, block.price)
    end

  end
end
