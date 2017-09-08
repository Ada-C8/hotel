# require_relative "reservations"
# require 'pry'
#
# class Block < Reservation
#   MAX_ROOMS = 5
#   def initialize(check_in, check_out, rooms_array)
#     super
#     if rooms_array.length > MAX_ROOMS
#       raise ArgumentError
#     end
#
#   end
# end


# class Block < Reservation
#   def initialize(check_in, check_out, rooms_array)
#     @bill = (@rate.sum * @nights * 0.85)
#     super
#   end
# end


# @reservation_id = rand(100000..999999)
# @check_in = Date.parse(check_in)
# @check_out = Date.parse(check_out)
# @nights = populate_nights(@check_in, @check_out)
# @num_nights = @nights.length
#
# @room_number = room.number
# @bill = @num_nights * room.rate
# @room = room
