require_relative 'spec_helper'

describe "Hotel::Block class " do
  describe "initialize" do
    it "initalizes" do
      check_in_str = "2018-10-03"
      check_out_str = "2018-10-06"
      room_ids = [1,2,3]
      block_id = "Amy's Party"
      discounted_rate = 5
      new_block = Hotel::Block.new(check_in_str, check_out_str,room_ids,discounted_rate,block_id)

      new_block.must_be_instance_of Hotel::Block
      # new_block.rooms.must_be_instance_of Array
      # new_block.rooms.each do |room|
      #   room.must_be_instance_of Hotel::Room
      # end

    end
  end
end
