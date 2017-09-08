require_relative 'reservations'
require_relative 'rooms'


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
    reservations << Reservation.new(guest, check_in, check_out, room)
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
      @blocks.each do |block_in_array|
        if block.id == id
          block.add_room(room)
        end
      end
    end

  end

  def assign_room(check_in, check_out, room_requested = nil)
    available_rooms = get_available_rooms(check_in, check_out)

    if room_requested.is_a? (Integer)
      available_rooms.each do |free_room|
        if free_room.number == room_requested
          return free_room
        end
      end
      raise StandardError.new "This room in unavailable"
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

  def get_available_rooms(date_begin, date_end)
    available_rooms = @rooms.clone

    @reservations.each do |res|
      overlap = (res.check_in...res.check_out).to_a & (date_begin...date_end).to_a

      if overlap[0] != nil
        available_rooms.delete(res.room)
      end
    end

    @blocks.each do |block|
      overlap = (block.check_in...block.check_out).to_a & (date_begin...date_end).to_a

      if overlap[0] != nil
        block.rooms_in_block.each do |room|
          available_rooms.delete(room)
        end
      end
    end

    return available_rooms
  end

  private


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
