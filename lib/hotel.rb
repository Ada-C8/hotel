require_relative "rooms"
require 'date'
require 'pry'

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
    begin
      if rooms_available(check_in, check_out).include?(room)
        new_reservation = Reservation.new(check_in, check_out, room)
        @reservations.push(new_reservation)
      else
        begin
        raise ArgumentError.new("That room is not available.")
        rescue ArgumentError => exception
          puts "#{exception}: #{check_in}-#{check_out}"
        end
      end
    end
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

  def rooms_reserved(date)
    reserved_rooms = []
    reservation_by_date(date).each do |reservation|
      reserved_rooms.push(reservation.room)
    end
    return reserved_rooms
  end


  def rooms_available(check_in, check_out)
    last_night = Date.parse(check_out) - 1
    available_rooms = Array.new(@rooms)

    reservation_by_date(check_in).each do |reservation|
      available_rooms.delete(reservation.room)
    end

    reservation_by_date(last_night.to_s).each do |reservation|
      available_rooms.delete(reservation.room)
    end

    return available_rooms
  end

  def block_reservation(check_in, check_out, rooms)
    @reservations.push(Block.new(check_in, check_out, rooms))
  end


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
