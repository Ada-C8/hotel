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


  def make_reservation(check_in, check_out, rooms)



    unavailable_rooms = []
    flag = true
    rooms.each do |room|
      if !(rooms_available(check_in, check_out).include?(room))
        unavailable_rooms.push(room.number)
        flag = false
      end
    end

      if flag == true
        @reservations.push(Reservation.new(check_in, check_out, rooms))

      else
        begin
          raise ArgumentError.new("Room: #{unavailable_rooms} not available: ")
        rescue ArgumentError => exception
          puts "#{exception}: #{check_in} - #{check_out}"
        end
      end
  end

  def reservation_by_date(date)
    my_date = Date.parse(date)
    raise ArgumentError.new("Invalid date") if my_date.nil?

    reservations_today = []
    @reservations.each do |reservation|
      if reservation.nights.nights_reserved.include?(my_date.to_s)
        reservations_today.push(reservation)
      end
    end
    return reservations_today
  end

  def rooms_reserved(date)
    reserved_rooms = []

    reservation_by_date(date).each do |reservation|
      reservation.rooms.each do |room|
        reserved_rooms.push(room)
      end
    end
    return reserved_rooms
  end


  def rooms_available(check_in, check_out)
    last_night = Date.parse(check_out) - 1
    available_rooms = Array.new(@rooms)

    reservation_by_date(check_in).each do |reservation|
      reservation.rooms.each do |room|
        available_rooms.delete(room)
      end
    end

    reservation_by_date(last_night.to_s).each do |reservation|
      reservation.rooms.each do |room|
        available_rooms.delete(room)
      end
    end

    return available_rooms
  end

  def block_reservation(check_in, check_out, rooms)
    @reservations.push(Block.new(check_in, check_out, rooms))
  end



end
#
# #this is an interface feature
# # def show_all_rooms
# #   room_display = []
# #   @rooms.each do |room|
# #     return
# #   end
# #   return room_display
# # end
