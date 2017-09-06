require_relative 'spec_helper'

describe "Block" do
  before do
    @number_of_rooms = 3
    @check_in = Date.new(2017,9,15)
    @check_out = Date.new(2017,9,17)
    @date_range = BookingSystem::DateRange.new(@check_in, @check_out)
    @new_block = BookingSystem::Block.new(@date_range, @number_of_rooms)
  end
  describe "#initialize" do
    it "ID should be an integer" do
      @new_block.id.must_be_kind_of Integer
    end
    it "Date_range can be called by .date_range" do
      @new_block.date_range.must_equal @date_range
    end
    it "Total cost should be an integer" do
      @new_block.block_cost.must_be_kind_of Integer
    end
    it "Returns the rigth total cost" do
      @new_block.block_cost.must_equal 1080
    end

  end

end #end of describe
