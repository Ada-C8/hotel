require 'csv'
require_relative 'room'
require_relative 'reservation'
require_relative 'hotel'

module Hotel
  class Block < Reservation
    attr_accessor :reservations
    attr_reader :block_id, :discount_rate, :num_of_rooms, :rooms
    def initialize(input_id, input_room_number, check_in_date, check_out_date, input_block_id = 0 )
      super
      @block_id = input_block_id.to_i
      @discount_rate = input_id.to_f
      @num_of_rooms = input_room_number.to_i
      raise ArgumentError.new "Blocks can contain a maximum of 5 rooms" if @num_of_rooms > 5
      @id = nil
      @room_number = nil
      @room = nil
      @rooms = add_rooms(check_in_date, check_out_date)
      @reservations = []
    end


    def add_rooms(begin_date, end_date)
      block_rooms = []
      available_rooms = Hotel.available_rooms(begin_date, end_date)
      i = 0
      num_of_rooms.times do
       block_rooms << available_rooms[i]
       i+= 1
     end
      return block_rooms
    end

    def add_reservations
      reservations.replace(Hotel.find_reservation_by_block_id(block_id))
    end

    def available(begin_search, end_search)
        if (begin_search >= @check_in) && (begin_search < @check_out) && (end_search >= @check_in) && (end_search <= @check_out)
          return false
        else
          return true
        end
    end

  end # => end of Block
end # => end of module
