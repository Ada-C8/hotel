require_relative '../lib/concerns/blockable'
require_relative 'spec_helper'

  describe "blockable" do
    before do
      @admin = Hotel::Admin.new
      @admin.create_block(Date.new(2012, 07, 16), Date.new(2012, 07, 19), "Bill Murray", "Japan", 5, 14)
    end
    it "can create a block" do

      @admin.block_list[0].must_be_instance_of Hotel::Block
    end

    it "won't take a room of blocks that is out of range" do
      proc{@admin.create_block(Date.new(2012, 07, 16), Date.new(2012, 07, 19), "Bill Murray", "Japan", 5, 27)}.must_raise ArgumentError
    end

    it "pushes the block into the block_list" do
      @admin.block_list.length.must_equal 1
    end

    it "can delete a block" do
      @admin.delete_block("Bill Murray")
      @admin.block_list.length.must_equal 0
    end

    it "can find a block from the block_list by name" do
      @admin.create_block(Date.new(2012, 07, 20), Date.new(2012, 07, 24), "Bill Murray", "Japan", 5, 14)
      this_block = @admin.find_block_name("Bill Murray")
      this_block.each do |block|
        block.must_be_instance_of Hotel::Block
      end
      this_block.length.must_equal 2
    end

    it "can find a block from the block_list by date" do
      this_block = @admin.find_block_by_date(Date.new(2012, 7, 18))
      this_block.each do |block|
        block.must_be_instance_of Hotel::Block
      end
      this_block.length.must_equal 1
      this_other_block = @admin.find_block_by_date(Date.new(2012, 7, 30), )
      this_other_block.length.must_equal 0

    end

    it "can convert a block to a reservation by name" do
      @admin.convert_block_to_reservation("Bill Murray")
      @admin.rooms_available?(Date.new(2012, 7, 18), Date.new(2012, 7, 19)).length.must_equal 6
      @admin.block_list.length.must_equal 0
    end

  end#end blockable
