# require_relative 'spec_helper'
#
# describe "Testing Block class" do
#
#   let(:rooms) { (1..5).to_a.map { |num| Hotel::Room.new(num) } }
#   let(:check_in) { Date.today }
#   let(:check_out) { Date.today + 2 }
#   let(:block) { Hotel::Block.new(Date.today, Date.today + 2, 0.8, rooms)}
#   let(:room_to_reserve) { rooms[0] }
#
#   describe "#initialize" do
#     before do
#       @rooms = []
#       4.times do |num|
#         @rooms << Hotel::Room.new(num + 1)
#       end
#
#       @check_in = Date.today
#       @check_out = Date.today + 2
#
#       @block = Hotel::Block.new(@check_in, @check_out, 0.8, @rooms)
#     end
#
#     it "Creates a Block with a check_in and check_out date, an array of rooms, and a discounted rate" do
#       room1 = @block.room_block[0]
#
#       @block.must_be_instance_of Hotel::Block
#       @block.check_in.must_equal @check_in
#       @block.check_out.must_equal @check_out
#       @block.room_block.must_equal @rooms
#       (@block.discount * room1.rate).must_be :<, room1.rate
#     end
#
#     it "Creates a block with no more than MAX_ROOMS num of rooms" do
#       @rooms << Hotel::Room.new(5)
#       @rooms << Hotel::Room.new(6)
#
#       proc {Hotel::Block.new(@check_in, @check_out, 0.8, @rooms) }.must_raise ArgumentError
#     end
#
#     it "Raises an error if it tries to include an unavailable room for the given dates in the block" do
#       unavail_room = @rooms[0]
#       unavail_room.reserve(@check_in, @check_out)
#
#       proc { Hotel::Block.new(@check_in, @check_out, 0.8, @rooms) }.must_raise ArgumentError
#     end
#
#     it "Adds itself to each room's list of blocks" do
#       @rooms.each do |room|
#         room.blocks.length.must_equal 1
#         room.blocks.must_include @block
#       end
#
#       new_block = Hotel::Block.new(@check_out, @check_out + 3, 0.8, @rooms)
#
#       @rooms.each do |room|
#         room.blocks.length.must_equal 2
#         room.blocks.must_include new_block
#       end
#
#     end
#   end
#
#   describe "#is_available" do
#
#     it "Returns true if a room in the block is available" do
#       room1 = rooms[0]
#       block.is_available?(room1).must_equal true
#
#       room1.reserve(check_in, check_out)
#       block.is_available?(room1).must_equal false
#     end
#
#     it "Raises an argument error if room isn't in the block" do
#       wrong_room = Hotel::Room.new(6)
#       proc { block.is_available?(wrong_room) }.must_raise ArgumentError
#     end
#   end
#
#   describe "#find_avail_in_block" do
#
#     it "Returns a list of rooms that are available in the block" do
#       block.find_avail_in_block.must_equal rooms
#
#       rooms[0].reserve(check_in, check_out)
#       rooms[1].reserve(check_in, check_out)
#
#       block.find_avail_in_block.must_equal rooms[2..-1]
#     end
#
#     it "Returns an empty array if no rooms available" do
#       block.find_avail_in_block.must_equal rooms
#
#       5.times do |num|
#         rooms[num].reserve(check_in, check_out)
#       end
#
#       block.find_avail_in_block.must_equal []
#     end
#   end
#
#   describe "#reserve" do
#
#     it "Reserves a room for the dates of the block" do
#       block_res = block.reserve(room_to_reserve)
#
#       block_res.check_in.must_equal check_in
#       block_res.check_out.must_equal check_out
#     end
#
#     it "Raises an error if it tries to reserve a room not in the block" do
#       room_outside_block = Hotel::Room.new(20)
#       proc { block.reserve(room_outside_block) }.must_raise ArgumentError
#     end
#
#     it "Raises an error if it tries to reserve an room that's already reserved" do
#       block.reserve(room_to_reserve)
#       proc {block.reserve(room_to_reserve) }.must_raise ArgumentError
#     end
#   end
#
#   describe "#discounted_cost" do
#     it "Returns the total cost of reserving a room in a block" do
#       expected_cost = (room_to_reserve.rate * 0.8) * (check_out - check_in).to_i
#       block.discounted_cost(room_to_reserve).must_equal expected_cost
#
#       room_to_reserve.rate = 300
#       updated_expected_cost = (room_to_reserve.rate * 0.8) * (check_out - check_in).to_i
#       block.discounted_cost(room_to_reserve).must_equal updated_expected_cost
#
#     end
#   end
#
# end
