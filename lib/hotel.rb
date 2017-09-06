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
    begin_search = Date.new(begin_date[0], begin_date[1], begin_date[2])
    end_search = Date.new(end_date[0], end_date[1], end_date[2])
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

end
