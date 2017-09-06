require_relative 'spec_helper'
# Hotel::Block.new(begin_date, end_date, num_of_rooms, discount_rate)

describe "Block" do
  describe "initialize" do
    it "should return an instance of a block" do
      output = Hotel::Block.new(0.5, 3, [2017,10,22], [2017,10,24])
      output.must_be_instance_of Hotel::Block
    end
    it "should have a date range, num of rooms and discount rate" do
      output = Hotel::Block.new(0.5, 3, [2017,10,22], [2017,10,24])
      output.must_respond_to :check_in
      output.must_respond_to :check_out
      output.must_respond_to :num_of_rooms
      output.must_respond_to :discount_rate
    end
    it "should raise error if intitalized with more than 5 rooms" do
      proc {Hotel::Block.new(0.5, 6, [2017,10,22], [2017,10,24])}.must_raise ArgumentError
    end
  end
end
