require_relative 'reservation'
require_relative 'block'
# The hotel has 20 rooms, and they are numbered 1 through 20
# Every room is identical, and a room always costs $200/night
# The last day of a reservation is the checkout day,
# so the guest should not be charged for that night
# For this wave, any room can be reserved at any time,
# and you don't need to check whether reservations
# conflict with each other (this will come in wave 2!)

module Property

  class Hotel

    attr_reader :rooms, :room_price

    def initialize
      @rooms = (1..20).to_a
      @room_price = 200
      @reservations = []
      @reserved_blocks = []
    end
  end
end

def available_rooms(check_in, check_out)
  dates = Property::Range.new(check_in, check_out)
  available_rooms = @rooms
end

def reserve_room(room,check_in,check_out)
  raise ArgumentError.new "Room unavailable." unless @rooms.include? room
  raise ArgumentError.new "Room #{room}is booked between
  #{check_in} and #{check_out}" unless available_rooms(check_in, check_out).include? room

  room_rez = Property::Reservation.new(room, checkin, checkout,@room_price)
  @rooms.pop(room)
  @reservations << room_rez
  return room_rez
end

def reserve_block(room_qty, check_in, check_out, price)
  rooms = availability(check_in, check_out)

  raise ArgumentError "Insufficient room availability" if @rooms.length < room_qty

  block_rez = Property::Block.new(room_qty.first(rooms), check_in, check_out, price)
  # rooms.each do |room|
  #   @availability.pop(room)
  # end
  @reserved_blocks << block_rez
  return block_rez
end

def list_reservations(date)
  @reservations.select { |rez| rez.contains(date) }
end

def reserve_from_block(block_rez)
  room = block_rez.reserve_individual_room
  room_rez = Reservation.new(room, block_rez.checkin, block_rez.checkout, block_rez.total_price)
end
