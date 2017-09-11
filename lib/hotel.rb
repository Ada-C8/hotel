require_relative 'reservation'
require_relative 'block'
module Property

  class Hotel

    attr_reader :reservations, :rooms, :room_price

    def initialize
      @rooms = (1..20).to_a
      @room_price = 200
      @reservations = []
      @reserved_blocks = []
      # @available = []
    end

    def available(checkin, checkout)
      dates = Range.new(checkin, checkout)
      available = @rooms
      overlap = @reservations.select do |rez|
        rez.overlap?(dates)
      end
      already_reserved = overlap.map do |rez|
        rez.room
      end
      available -= already_reserved
      return available
    end
    # pseudo : def no_check_in_on_same_day_as_check_out(room)
    #   for room's check out date
    #     do not allow check_in date to start on same day
    #       for that room
    #   use overlap? to control for this?
    # make sure adjusting availability doesn;t affect the price
    #     end

    def reserve_room(room, check_in, check_out)
      raise ArgumentError.new "Room unavailable." unless @rooms.include? room
      raise ArgumentError.new "Room #{room}is booked between
      # #{check_in} and #{check_out}" unless available(check_in, check_out).include? room
      room_rez = Reservation.new(room, check_in, check_out, @room_price)
      @reservations << room_rez
      return room_rez
    end

    def reserve_block(room_qty, check_in, check_out, price)
      rooms = availability(check_in, check_out)

      raise ArgumentError "Insufficient room availability" if @rooms.length < room_qty

      block_rez = Property::Block.new(room_qty.first(rooms), check_in, check_out, price)
      rooms.each do |room|
        @availability.pop(room)
      end
      @reserved_blocks << block_rez
      return block_rez
    end

    def list_rez(date)
      return @reservations.select { |rez| rez.contains(date) }
    end

    def reserve_from_block(block_rez)
      room = block_rez.reserve_individual_room
      room_rez = Reservation.new(room, block_rez.check_in, block_rez.check_out, block_rez.price)
    end
  end
end
