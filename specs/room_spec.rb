# require_relative 'spec_helper'
#
# describe "Room" do
#   describe "initialize" do
#     it "Creates a room instance object with a room number" do
#       room = Hotel::Room.new(1)
#
#       room.must_be_instance_of Hotel::Room
#       room.number.must_equal 1
#
#       another = Hotel::Room.new(100) #TODO 1. decide- Testing edge cases... could check for room parameters. Currently allowing rooms to be 'numbered' however.
#       another.number.must_equal 100
#     end
#
#     it "Creates a room with a rate of $200" do
#       room = Hotel::Room.new(1)
#
#       room.rate.must_equal 200
#     end
#
#     it "Creates a room with an empty array of reserved dates" do
#       room = Hotel::Room.new(1)
# 
#       room.dates_reserved.must_be_kind_of Array
#       room.dates_reserved.must_equal []
#     end
#
#     it "Creates a room with an empty array of reservations" do
#       room = Hotel::Room.new(1)
#
#       room.reservations.must_be_kind_of Array
#       room.reservations.must_equal []
#     end
#   end
#
#   describe "reserve method" do
#     it "Reserves room for a given date range" do
#       room = Hotel::Room.new(1)
#       date = '2017-10-12'
#       room.reserve(date, 3)
#
#       room.dates_reserved.must_include Date.parse('2017-10-12')
#       room.dates_reserved.must_include Date.parse('2017-10-14')
#       room.dates_reserved.wont_include Date.parse('2017-10-11')
#       room.dates_reserved.wont_include Date.parse('2017-10-15')
#
#       #TODO test for updated structure
#
#     end
#
#     it "Creates a reservation instance" do
#       # TODO next!! Probably in reservations
#     end
#
#     it "Adds a hash of reservation and dates_reserved to a reservations list" do
#       # TODO
#     end
#   end
# end

#============== OLD WORK ====================#
