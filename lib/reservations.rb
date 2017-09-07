require 'date'
require_relative 'rooms'

class Reservation
  attr_reader :check_in, :check_out, :nights, :bill, :num_nights, :room_numbers, :reservation_id, :rooms
  def initialize(check_in, check_out, rooms_array)
    puts "Are you an array? #{rooms_array.class}"
    @reservation_id = rand(100000..999999)
    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)
    @nights = populate_nights(@check_in, @check_out)

    @num_nights = @nights.length
    @rooms = rooms_array
    puts "BYEEEE! #{rooms_array.class}"
    @rate = rooms_array.map {|room| room.rate}
    @bill = @num_nights * @rate.sum
    @room_numbers = rooms_array.map {|room| room.number}
  end


private
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
