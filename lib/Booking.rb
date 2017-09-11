require 'date'
require_relative 'Reservation'
require_relative 'Room'
require_relative 'Block'
module HotelBooking

  class Hotel
    attr_reader :all_rooms, :all_reservations, :all_blocks
    NUM_STANDARD_ROOMS = 20

    def initialize
      @all_rooms = HotelBooking::Hotel.setup_rooms
      @all_reservations = []
      @all_blocks = []
    end

    def available_rooms(check_in,check_out, block_id = nil)

      check_valid_dates(check_in,check_out)
      @all_rooms.select {|room| room.available_all_days?(check_in, check_out)}
    end

    def make_block(check_in,check_out,room_ids,discounted_rate)
      check_in_date = Date.parse(check_in)
      check_out_date = Date.parse(check_out)

      check_valid_dates(check_in_date,check_out_date)
      check_valid_block(check_in_date,check_out_date,room_ids)

      block_id = "B" + "#{@all_blocks.count + 1}"

      # block_rooms = []
      #
      # room_ids.each do |id|
      #   room = find_room_by_id(id)
      #   block_rooms << room
      # end

      block = HotelBooking::Block.new(check_in_date,check_out_date,room_ids,discounted_rate,block_id)

      room_ids.each do |room_id|
        room= find_room_by_id(room_id)
        room.block_room(check_in_date,check_out_date,block_id)
      end

      @all_blocks << block

    end

    def make_reservation(check_in,check_out,room_id, guest_id=nil)

      reservation_id = (@all_reservations.count + 1)
      room= find_room_by_id(room_id)
      check_in_date = Date.parse(check_in)
      check_out_date = Date.parse(check_out)

      check_valid_dates(check_in_date,check_out_date)

      if available_rooms(check_in_date,check_out_date).include?(room)

        reservation = HotelBooking::Reservation.new(check_in_date,check_out_date,room_id, reservation_id)

        room.reserve_room(check_in_date,check_out_date,reservation_id, guest_id)

        @all_reservations << reservation
      else
        raise ArgumentError.new("This room is already reserved for these dates")
      end

    end

    def make_block_reservation(block_id,room_id,guest_id = nil)
      reservation_id = (@all_reservations.count + 1)
      room= find_room_by_id(room_id)
      block= find_block_by_id(block_id)

      raise ArgumentError.new("This block does not exist") if !(@all_blocks.include?(find_block_by_id(block_id)))
      raise ArgumentError.new("This room is not in the block") if !(block.room_ids.include?(room_id))

      reservation = HotelBooking::BlockReservation.new(block.check_in,block.check_out,room_id, reservation_id, block.discounted_rate)
      reservation.block_id = block_id

      room.reserve_block_room(block_id,reservation.id, guest_id=nil)

      @all_reservations << reservation

    end

    def find_room_by_id(room_id)
      @all_rooms.each {|room| return room if room.id == room_id}

      raise ArgumentError.new "Sorry, we don't have a room matching that ID number."
    end

    def find_res_by_date(date_str)
      date_object= Date.parse(date_str)
      @all_reservations.select {|reservation| ((reservation.check_in)..(reservation.check_out)).include?(date_object)}
    end

    def find_block_by_id(block_id)

      @all_blocks.each {|block| return block if block.id == block_id}
      raise ArgumentError.new "Sorry, we don't have a block matching that ID number."
    end

    def find_available_rooms_by_block(block_id)
      block= find_block_by_id(block_id)
      
      block_rooms = block.room_ids.map {|id| find_room_by_id(id)}

      block_rooms.select {|room| room.blocks_available.include?(block_id)}
    end

    def check_valid_block(check_in,check_out,room_ids)
      raise ArgumentError.new("Number of rooms in a block must be 5 or under") if room_ids.count > 5

      available_rooms_ids = available_rooms(check_in,check_out).map {|room| room.id}

      room_ids.each do |room_id|
        raise ArgumentError.new("This room is already reserved for the dates provided") if !(available_rooms_ids.include?(room_id))
      end

      return true

    end

    def check_valid_dates(check_in, check_out)
      if check_in < Date.today || check_out < Date.today
        raise ArgumentError.new("Can't make reservations for days earlier than today")
      end

      if check_in.class != Date ||check_out.class != Date
        raise ArgumentError.new("Please provide a valid date")
      end

      if check_out < check_in
        raise ArgumentError.new("Invalid Date Range: Check out date is earlier than check-in date.")
      end

    end

    def self.setup_rooms
      i = 1
      standard_rooms = []

      until standard_rooms.count == NUM_STANDARD_ROOMS
        room =  HotelBooking::Room.new(i)
        standard_rooms << room
        i += 1
      end

      return standard_rooms
    end

  end

end
