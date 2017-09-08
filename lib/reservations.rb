require 'date'
require_relative 'nights'
require_relative 'rooms'

class Reservation
  MAX_ROOMS = 5
  attr_reader :check_in, :check_out, :bill, :room_numbers, :reservation_id, :rooms, :nights

  def initialize(check_in, check_out, rooms_array, discount=1)
    if rooms_array.length > MAX_ROOMS
      raise ArgumentError.new("The maximum number of rooms that can be reserved is 5")
    end
    @nights = Nights.new(check_in, check_out)
    @reservation_id = rand(100000..999999)
    @rooms = rooms_array
    @rate = @rooms.map { |room| room.rate }
    @room_numbers = rooms_array.map {|room| room.number}
    @discount = discount
  end

  def bill
    @nights.num_nights * @rate.sum * @discount
  end

  private
  # def check_rooms(rooms_array)
  #   room_numbers = []
  #   rooms_array.each do |room|
  #     room_numbers.push(room.number)
  #   end
  #
  #   if room_numbers.length != room_numbers.uniq
  #     raise ArgumentError.new("You cannot book the same room number twice")
  #   end
  # end
  #


end

# begin
#   # here is the code that could raise ArgumentError
# rescue ArgumentError
#   puts "there was an error"
# else
#   puts "no error"
# end
