require_relative 'spec_helper'

describe "Block child class" do

describe "initialization" do
  before do
    @block = Hotel::BlockRoom.new('sept 1 2017', 'sept 2 2017', 3, "Fernandez", 10)
  end

  it "Can create an instance of block" do
    @block.must_be_instance_of Hotel::BlockRoom
  end

  it "Can call methods regarding instance methods created" do
    @block.reservation_array.must_be_instance_of Array
    @block.num_of_rooms.must_equal 3
    @block.discount.must_equal 10
    @block.check_in.must_be_instance_of Date
    @block.check_out.must_be_instance_of Date
    @block.collection_of_rooms.must_be_instance_of Array
    @block.cost.must_equal 200
    @block.booked_rooms.must_be_instance_of Array
    @block.available_rooms.must_be_instance_of Array
  end


end

end #block describe
