require_relative "rooms"
require 'date'
require 'pry'

class Hotel
  attr_reader :rooms, :reservations, :blocks
  def initialize
    @blocks = []
    @reservations = []
    @rooms = []
    (1..20).each do |number|
      @rooms.push(Room.new(number, 200))
    end
  end

  #data it holds: reservations, rooms, blocks;
  #what it manipulates: reservations

  def make_reservation(check_in, check_out, rooms)
    unavailable_rooms = []

    if room_flagged_available?(check_in, check_out, rooms, unavailable_rooms)
      @reservations.push(Reservation.new(check_in, check_out, rooms))
    else
      raise ArgumentError.new("Room: #{unavailable_rooms} not available")
    end
  end



  def reservation_by_date(date)
    my_date = Date.parse(date)
    raise ArgumentError.new("Invalid date") if my_date.nil?

    reservations_today = []
    @reservations.each do |reservation|
      if reservation.nights_reserved.include?(my_date.to_s)
        reservations_today.push(reservation)
      end
    end
    return reservations_today
  end


  def rooms_reserved(check_in, check_out)
    nights = Nights.new(check_in, check_out)

    reserved_rooms = []
    nights.nights_reserved.each do |night|
      reservation_by_date(night).each do |reservation|
        reservation.rooms.each do |room|
          reserved_rooms.push(room)
        end
      end
    end
    return reserved_rooms
  end


  def rooms_available(check_in, check_out)
    nights = Nights.new(check_in, check_out)
    available_rooms = Array.new(@rooms)

    nights.nights_reserved.each do |night_reserved|
      remove_rooms_from_available(night_reserved, available_rooms)
    end
    return available_rooms
  end



  #BLOCKS

  def make_block(check_in, check_out, rooms, discount=1)
  block = Block.new(check_in, check_out, rooms, discount)
  @blocks.push(block)
    return block.id
  end

  def find_block(id)
    @blocks.each do |block|
      if block.id == id
        return block
      end
    end
    raise ArgumentError.new("That block doesn't exist")
  end

  def reserve_from_block(id, rooms)
    block_reserved = find_block(id).make_reservation(rooms)
    @reservations.push(block_reserved)
    return block_reserved
  end
  #still left to do: make sure a room can't be reserved if it's set aside in a block; within block: make sure a room cannot be added to the same block twice.

  private

  def remove_rooms_from_available(search_date, available_rooms)
    reservation_by_date(search_date.to_s).each do |reservation|
      reservation.rooms.each do |room|
        available_rooms.delete(room)
      end
    end
  end

  def room_flagged_available?(check_in, check_out, rooms, unavailable_rooms)
    flag = true
    rooms.each do |room|
      if !(rooms_available(check_in, check_out).include?(room))
        unavailable_rooms.push(room.number)
        flag = false
      end
    end
    return flag
  end
end

#stores and accesses rooms and blocks.
