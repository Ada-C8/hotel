# require_relative '../specs/spec_helper'
#
# test_ob = Hotel::Block.new
#
# test_ob.add_reservation_to_block

describe "Block tests" do
  before do
    @block = Hotel::Block.new([1,2,3,4], Date.new(2017,2,2), Date.new(2017,2, 7), discount_percent: 0)
    @block.make_reservation(1, Date.new(2017,2,2), Date.new(2017,2, 7), discount_percent: 0)
  end

  describe "initialize" do
    it "Returns a block object" do

      @block.must_be_instance_of Hotel::Block
    end
  end # initialize

  it "adds to reservations_array" do
    @block.reservations_array.must_be_instance_of Array
    @block.reservations_array.length.must_equal 1
  end

end # block tests
