require_relative "rooms"
require 'date'

class Hotel
  attr_reader :rooms, :reservations
  def initialize
    @reservations = []
    @rooms = []

    (1..20).each do |room|
      @rooms.push(Room.new(room, 200))
    end
  end

  def make_reservation(check_in, check_out, room)
    valid_date(check_in, check_out)
    new_reservation = Reservation.new(check_in, check_out, room)
    @reservations.push(new_reservation)
  end


  def reservation_by_date(date)
    my_date = Date.parse(date)
    raise ArgumentError.new("Invalid date") if my_date.nil?


    reservations_today = []
    @reservations.each do |reservation|
      if reservation.nights.include?(my_date.to_s)
        reservations_today.push(reservation)
      end
    end
    return reservations_today
  end


#will use !(rooms_reserved) to return the opposite of the reserved rooms
  def available_rooms(check_in, check_out)
    return !(roomes_reserved(check_in)) && !(rooms_reserved(check_out))
  end

#reservation_by_date(date) returns an array of reservations for the date; the each statement iterates through those reservations and gets the room number.

  def rooms_reserved(date)
    rooms_reserved_today = []
    reservation_by_date(date).each do |reservation|
      rooms_reserved_today.push(reservation.room)
    end
    return rooms_reserved_today
  end



  # def available_rooms(date_start, date_end)
  #   valid_date(date_start, date_end)
  #   Date.parse(date_start)
  #   Date.parse(date_end)
  #   vacant = []
  #   #search through the reservations to see if the room number is included in any of the reservations
  # end

  private
  def valid_date(check_in, check_out)
    start = Date.parse(check_in)
    finish = Date.parse(check_out)

    if start.nil? || finish.nil?
      raise ArgumentError.new("Invalid Input")
    elsif finish <= start
      raise ArgumentError.new("Invalid date range. Checkout date must be after check-in date.")
    elsif start < Date.today
      raise ArgumentError.new("That date has already passed. Please select a valid check-in date.")
    end
  end
end

#this is an interface feature
  # def show_all_rooms
  #   room_display = []
  #   @rooms.each do |room|
  #     return
  #   end
  #   return room_display
  # end
