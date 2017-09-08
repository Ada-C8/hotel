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
    flag = flag_a_room(check_in, check_out, rooms, unavailable_rooms)

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
      array_each_do(reservation.rooms, reserved_rooms)
    end

    
    # array_each_do(reservation_by_date(date), array_each_do(reserved_rooms, reservation_by_date(date)))

    # reservation_by_date(date).each do |reservation|
    #   reservation.rooms.each do |room|
    #     push_to_array(reserved_rooms, room)
    #   end
    # end
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


  def block_reservation(check_in, check_out, rooms)
    @reservations.push(Block.new(check_in, check_out, rooms))
  end

  private

  def remove_rooms_from_available(search_date, available_rooms)
    reservation_by_date(search_date.to_s).each do |reservation|
      reservation.rooms.each do |room|
        available_rooms.delete(room)
      end
    end
  end

  def flag_a_room(check_in, check_out, rooms, unavailable_rooms)
    flag = true
    rooms.each do |room|
      if !(rooms_available(check_in, check_out).include?(room))
        unavailable_rooms.push(room.number)
        flag = false
      end
    end
    return flag
  end

  def push_to_array(array, arg)
    array.push(arg)
  end

  def array_each_do(arr, array)
    arr.each {|arg| push_to_array(array, arg)}
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
