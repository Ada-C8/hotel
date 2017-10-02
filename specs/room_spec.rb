#################################
# decided I don't need this class
#################################


# require_relative '../specs/spec_helper'
#
# describe 'Room' do
#   describe 'initialize' do
#     it 'creates an instance of Room' do
#     end # end test
#   end # end #initialize
#
#   describe 'self.all' do
#     it "Returns an Array when Room.all is called" do
#       Hotel::Room.all.must_be_kind_of Array
#     end # end test
#
#     it "Verifies the number of rooms is correct" do
#       total_rooms = CSV.read("support/rooms.csv", 'r').length
#       Hotel::Room.all.length.must_equal total_rooms
#     end # end test
#
#     it "Verifies everything in the Array is a Room" do
#       Hotel::Room.all.each do |room|
#         room.must_be_kind_of Hotel::Room
#       end
#     end # end test
#
#     it "Matches the first and last room numbers with the CSV file" do
#       Hotel::Room.all.first.room_number.must_equal 1
#       Hotel::Room.all.last.room_number.must_equal 20
#     end # end test
#   end # end #self.all
#
#   describe 'self.find(room_number)' do
#     it "Can find the room 1 from the CSV" do
#       Hotel::Room.find(1).room_number.must_equal Hotel::Room.all.first.room_number
#     end
#
#     it "Can find the last order from the CSV" do
#       Hotel::Room.find(20).room_number.must_equal Hotel::Room.all.last.room_number
#     end
#     it 'raises an ArgumentError if room number does not exist' do
#       proc{Hotel::Room.find(666)}.must_raise Hotel::InvalidRoomError
#     end # end test
#   end # end #self.find(room_number)
# end # end all Room tests
