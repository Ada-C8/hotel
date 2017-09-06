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

  def self.cost(input_reservation)
    self.all_reservations
    all_reservations.each do |reservation|
      return (reservation.total_cost) if reservation.id == input_reservation
    end
  end

end
