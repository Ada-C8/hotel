# require_relative './spec_helper'
# require_relative '../lib/blocks'
#
# describe "#BLOCKS" do
#   it "Can be initialized" do
#     @block_reserve = {check_in: "January 20, 2018", check_out: "January 25, 2018", rooms: [Room.new(25, 200), Room.new(26, 150), Room.new(27, 250)]}
#
#     @my_block = Block.new(@block_reserve[:check_in], @block_reserve[:check_out], @block_reserve[:rooms])
#
#     @my_block.must_be_instance_of Block
#     @my_block.must_be_kind_of Reservation
#
#   end
#
#   it "Will not create a block with more than 5 rooms." do
#     @block2 = {check_in: "January 20, 2018", check_out: "January 25, 2018", rooms: [Room.new(25, 200), Room.new(26, 150), Room.new(27, 250), Room.new(28, 100), Room.new(29, 300), Room.new(30, 140)]}
#
#
#
#     proc {Block.new(@block2[:check_in], @block2[:check_out], @block2[:rooms])}.must_raise ArgumentError
#
#
#   end
# end
