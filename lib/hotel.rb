require_relative 'reservations'
require_relative 'rooms'
require_relative 'block'
require_relative 'date_range'

require 'pry'

module Hotel
  class Hotel

  attr_reader :rooms, :reservations, :blocks

  def initialize
    @rooms = []
    create_rooms
    @reservations = []
    @blocks = []
  end

  def make_reservation(guest, check_in, check_out, room_requested = nil)
    room = assign_room(check_in, check_out, room_requested)
    reservations << Reservation.new(guest, check_in, check_out, room, false)
  end

  def make_reservation_from_block(guest, block_id)
    block = find_block_by_id(block_id)

    room = get_available_rooms_from_block(block)[0]

    reservations << Reservation.new(guest, block.check_in, block.check_out, room, block_id)
  end

  def make_block(check_in, check_out, num_rooms)
    id = assign_id

    block = Block.new(check_in, check_out, id)

    blocks << block

    if num_rooms.between?(1, 5) == false
      raise StandardError.new "only possible to book 5 rooms in a block"
    end

    num_rooms.times do
      room = assign_room(check_in, check_out)
      block.add_room(room)
    end

    return block
  end

  #THERE HAS TO BE A BETTER WAY TO DO THIS.
  def assign_room(check_in, check_out, room_requested = nil)
    available_rooms = get_available_rooms(check_in, check_out)

    raise StandardError.new "no more rooms available for that date" if available_rooms.empty?

    if room_requested.is_a? (Integer)
      available_rooms.each do |empty_room|
        if empty_room.number == room_requested
          return empty_room
        end
      end
      raise StandardError.new "This room is unavailable"
    else
      room = available_rooms[0]
      return room
    end
  end

  def get_res_by_date(date)
    res_by_date = []
    @reservations.each do |res|
      if res.include_date?(date)
        res_by_date << res
      end
    end
    return res_by_date
  end

  def get_available_rooms(check_in, check_out)
    available_rooms = @rooms.clone

    res_date = DateRange.new(check_in, check_out)

    @reservations.each do |res|
      unless res_date.overlap(res).empty?
        available_rooms.delete(res.room)
      end
    end

    @blocks.each do |block|
      unless res_date.overlap(block).empty?
        block.rooms_in_block.each do |room|
          available_rooms.delete(room)
        end
      end
    end

    # @reservations.each do |res|
    #   overlap = (res.check_in...res.check_out).to_a & (date_begin...date_end).to_a
    #
    #   if overlap[0] != nil
    #     available_rooms.delete(res.room)
    #   end
    # end
    #
    # @blocks.each do |block|
    #   overlap = (block.check_in...block.check_out).to_a & (date_begin...date_end).to_a
    #
    #   if overlap[0] != nil
    #     block.rooms_in_block.each do |room|
    #       available_rooms.delete(room)
    #     end
    #   end
    # end

    return available_rooms
  end

  def get_available_rooms_from_block(block)

    available_rooms = block.rooms_in_block

    reservations.each do |res|
      if res.block_id == block.id
          available_rooms.delete(res.room)
      end
    end

    return available_rooms
  end

  private

  def find_block_by_id(block_id)
    blocks.each do |block|
      if block.id == block_id
        return block
      end
    end
    raise StandardError.new "this id doesn't exit"
  end

  # def find_room_by_number(room_number)
  #   rooms.each do |room|
  #     if room.number == room_number
  #       return room
  #     end
  #   end
  #   raise StandardError.new "this room doesn't exist"
  # end

  def assign_id
    id = 111111

    blocks.each do |block|
      while block.id == id
        id = rand(899999) + 100000
      end
    end
    return id
  end

  def create_rooms
    (1..20).each do |num|
      @rooms << Room.new(num)
    end
  end

  end #end of class
end #end of module
