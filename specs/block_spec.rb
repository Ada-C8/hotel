require_relative 'spec_helper'

describe 'Block' do

  before(:all) do
    @check_in = Date.new(2018, 03, 11)
    @check_out = Date.new(2018, 03, 15)
    @name = "guest"
    @rooms = [1,2,3]
  end

  describe "initialize" do
    it "creates a new instance of Block" do
      Block.new(@name, @rooms, @check_in, @check_out).must_be_instance_of Block
    end

    it "initializes with a new instance of DateRange stored in @dates" do
      block = Block.new(@name, @rooms, @check_in, @check_out)
      block.dates.must_be_instance_of DateRange
    end

    it "will not initialize if given more than 5 rooms or less than 1" do
      too_many_rooms = [1,2,3,4,5,6]
      proc { Block.new(@name, too_many_rooms, @check_in, @check_out)}.must_raise ArgumentError
    end

    it "will not initialize if given less than 1 room" do
      no_rooms_given = []
      proc { Block.new(@name, no_rooms_given, @check_in, @check_out)}.must_raise ArgumentError
    end
  end

  describe "total_cost" do
    it "returns total cost based on discounted price_night" do
      block = Block.new(@name, @rooms, @check_in, @check_out)
      block.total_cost.must_equal "$640.00"
    end
  end

end
