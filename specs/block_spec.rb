require_relative 'spec_helper'

describe "My_Hotel::Block" do
  before do
    @feb1 = Date.civil(2017,2,1)
    @feb6 = Date.civil(2017,2,6)
    rooms= [1, 2, 3, 4]
    @new_block = My_Hotel::Block.new(@feb1..@feb6, rooms, 0.75)
  end

  describe "initialize" do
    it "can be created" do
      @new_block.must_be_kind_of My_Hotel::Block
      @new_block.room_numbers.must_be_kind_of Array
      @new_block.block_id.must_be_nil
    end
  end

  describe "set_block_id" do
    it "can create a 4 number block_id string" do
      @new_block.set_block_id
      @new_block.block_id.must_be_kind_of String
      @new_block.block_id.length.must_equal 4
    end
  end

end
