require 'csv'
require_relative 'room'
require_relative 'reservation'

module Hotel

  ROOM_NUMBERS = (1..20)

  HOTEL_ROOMS = ROOM_NUMBERS.map {|num| Hotel::Room.new(num, 200)}


  def self.all_rooms
    return HOTEL_ROOMS
  end

  def self.find_room(input_id)
    HOTEL_ROOMS.each do |room|
      return room if room.id == input_id
    end
  end

  def self.find_by_date(input_date)
    return 5
  end

  def self.find_reservation(input_id)
    all_reservations = self.all_reservations
    all_reservations.each do |reservation|
      return reservation if reservation.id == input_id
    end
  end

  def self.find_reservation_by_block_id(input_id)
    blocked_reservations = []
    all_reservations = self.all_reservations
    all_reservations.each do |reservation|
      blocked_reservations << reservation if reservation.block_id == input_id
    end
    return blocked_reservations
  end

  def self.all_reservations
    all_reservations = []
    CSV.read('support/reservations.csv').each do |row|
      reservation_id = row[0]
      room_num = row[1]
      check_in_date = row[2].split
      check_out_date = row[3].split
      all_reservations.push(Hotel::Reservation.new(reservation_id, room_num, check_in_date, check_out_date))
    end
    return all_reservations
  end

  def self.all_blocks
    all_blocks =[]
    CSV.read('support/blocks.csv').each do |row|
      block_rate = row[0]
      num_of_rooms = row[1]
      check_in_date = row[2].split
      check_out_date = row[3].split
      block_id = row[4]
      all_blocks.push(Hotel::Block.new(block_rate, num_of_rooms, check_in_date, check_out_date, block_id))
    end
    return all_blocks
  end

  def self.cost(input_reservation)
    all_reservations = self.all_reservations
    all_reservations.each do |reservation|
      return (reservation.total_cost) if reservation.id == input_reservation
    end
  end

  def self.access_reservation(input_date)
    search_date = Date.new(input_date[0], input_date[1], input_date[2])
    search_reservations = []
    all_reservations = self.all_reservations
    all_reservations.each do |reservation|
      search_reservations << reservation if search_date.between?(reservation.check_in, reservation.check_out - 1)
    end
    raise ArgumentError.new "No Reservations are present on that date" if search_reservations.length == 0
    return search_reservations
  end

  def self.available_rooms(begin_date, end_date)
    begin_search = Date.new(begin_date[0].to_i, begin_date[1].to_i, begin_date[2].to_i)
    end_search = Date.new(end_date[0].to_i, end_date[1].to_i, end_date[2].to_i)
    unavailable_rooms = []
    all_reservations = self.all_reservations
    all_reservations.each do |reservation|
      if (begin_search >= reservation.check_in) && (begin_search < reservation.check_out) && (end_search >= reservation.check_in) && (end_search <= reservation.check_out)
        unavailable_rooms<< reservation.room
      end
    end
    available_rooms = HOTEL_ROOMS - unavailable_rooms
    return available_rooms
  end

  def self.blocked_rooms(begin_date, end_date)
    begin_search = Date.new(begin_date[0].to_i, begin_date[1].to_i, begin_date[2].to_i)
    end_search = Date.new(end_date[0].to_i, end_date[1].to_i, end_date[2].to_i)
    blocked_rooms = []
    all_the_blocks = self.all_blocks
    all_the_blocks.each do |block|
      if (begin_search >= block.check_in) && (begin_search < block.check_out) && (end_search >= block.check_in) && (end_search <= block.check_out)
        block.rooms.each do |room|
          blocked_rooms << room
        end
      end
    end
    return blocked_rooms
  end

  def self.truly_available(begin_date, end_date)
    available_rooms = self.available_rooms(begin_date, end_date)
    blocked_rooms = self.blocked_rooms(begin_date, end_date)
    truly_available = available_rooms - blocked_rooms
    return truly_available
  end


  def self.reserve_room(begin_date, end_date)
    # begin_reservation = Date.new(begin_date[0], begin_date[1], begin_date[2])
    # end_reservation = Date.new(end_date[0], end_date[1], end_date[2])
    available_rooms = self.available_rooms(begin_date, end_date)
    raise ArgumentError.new "No rooms are available for this date range" if available_rooms.length == 0
    return Hotel::Reservation.new(10, available_rooms[0].id, begin_date, end_date)
  end

end
