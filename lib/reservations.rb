require 'date'
require_relative 'rooms'

class Reservation
  MAX_ROOMS = 5
  attr_reader :check_in, :check_out, :nights, :bill, :num_nights, :room_numbers, :reservation_id, :rooms

  def initialize(check_in, check_out, rooms_array, discount=1)
    if rooms_array.length > MAX_ROOMS
      raise ArgumentError.new("The maximum number of rooms that can be reserved is 5")
    end


    @reservation_id = rand(100000..999999)
    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)
    @nights = populate_nights(@check_in, @check_out)

    @num_nights = @nights.length
    @rooms = rooms_array
    @rate = @rooms.map { |room| room.rate }
    @bill = @num_nights * @rate.sum * discount
    @room_numbers = rooms_array.map {|room| room.number}
  end


  private
  def check_rooms(rooms_array)
    room_numbers = []
    rooms_array.each do |room|
      room_numbers.push(room.number)
    end

    if room_numbers.length != room_numbers.uniq
      raise ArgumentError.new("You cannot book the same room number twice")
    end
  end


  def populate_nights(check_in, check_out)
    nights = []
    until check_in == check_out
      nights.push(check_in.to_s)
      check_in += 1
    end
    return nights
  end
end

# begin
#   # here is the code that could raise ArgumentError
# rescue ArgumentError
#   puts "there was an error"
# else
#   puts "no error"
# end
