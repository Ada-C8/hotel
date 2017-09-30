require 'date'
require_relative 'nights'
require_relative 'rooms'

class Reservation
  MAX_ROOMS = 5
  attr_reader :check_in, :check_out, :bill, :room_numbers, :reservation_id, :rooms, :nights_reserved, :nights

  def initialize(check_in, check_out, rooms_array, discount=1)
    if rooms_array.length > MAX_ROOMS
      raise ArgumentError.new("The maximum number of rooms that can be reserved is 5")
    end
    no_double_booking_rooms(rooms_array)

    @nights = Nights.new(check_in, check_out)
    @nights_reserved = @nights.nights_reserved #added this so that reservation can work with its own variables without directly manipulating Night class variables.

    @rooms = rooms_array
    @rate = @rooms.map { |room| room.rate }
    @discount = discount
    @reservation_id = rand(100000..999999)
  end

  def bill
    # @nights.num_nights * @rate.sum * @discount
    # this method accesses an instance method from another class. refactoring below:
    @nights_reserved.length * @rate.sum * @discount
  end

  def room_numbers
    @rooms.map {|room| room.number}
  end

  private
  def no_double_booking_rooms(rooms)
    booking_rooms = rooms.map {|room| room.number}
    unique_booking_rooms = booking_rooms.uniq

    if booking_rooms != unique_booking_rooms
      raise ArgumentError.new ("You cannot double-book a room.")
    end
  end
end

# begin
#   # here is the code that could raise ArgumentError
# rescue ArgumentError
#   puts "there was an error"
# else
#   puts "no error"
# end
