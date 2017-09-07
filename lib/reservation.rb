# require 'date'
# require_relative 'building'
#
#
# module Hotel
#
#   class Reservation
#     attr_reader :check_in, :nights, :room, :check_out
#
#     def initialize(check_in_date, nights, room)
#       @id = "#{check_in_date}_#{nights}_" #append guest when able, test for id
#       @check_in = Date.parse(check_in_date)
#       @nights = nights
#       @room = room
#       @check_out = @check_in + nights #NOTE excessive, but helpful for my head wrapping around the dates
#     end
#
#   end # Reservation class
#
# end # Hotel module

#============== OLD WORK ====================#
