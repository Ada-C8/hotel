require 'date'
require_relative 'rooms'

class Reservation
  attr_reader :check_in, :check_out, :nights, :bill, :num_nights, :room_number, :reservation_id
  def initialize(check_in, check_out, room)
    @reservation_id = rand(100000..999999)
    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)

    @nights = populate_nights(@check_in, @check_out)
    @num_nights = @nights.length
    @room_number = room.number
    @bill = @num_nights * room.rate
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
