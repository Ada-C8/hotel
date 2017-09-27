require_relative 'spec_helper.rb'

describe "block" do

  it "can initialize a new block" do
    block = Hotel_System::Block.new(3, "1-1-2018", "1-5-2018", 0.8)
    block.must_be_instance_of Hotel_System::Block
  end

  it "will raise an argument error if try to add too many rooms to a block" do
    proc {block = Hotel_System::Block.new(10, "1-1-2018", "1-5-2018", 0.8)}.must_raise ArgumentError
  end

  it "can add a room to a block" do
    block = Hotel_System::Block.new(3, "1-1-2018", "1-5-2018", 0.8)
    block.add_room_to_block(1)
    block.add_room_to_block(3)
    block.array_of_room_objects.length.must_equal 2
    block.array_of_room_objects.must_include 3
  end

  it "checks that the block check in date is not in the past" do
    proc {Hotel_System::Block.new(3, "1-1-2015", "1-1-2018", 0.8)}.must_raise ArgumentError
      begin
        Hotel_System::Block.new(3, "1-1-2015", "1-1-2018", 0.8)
      rescue ArgumentError => e
        e.message.must_equal("Invalid check in date")
      end
    end

    it "checks the block check out date is not in the past" do
      proc {Hotel_System::Block.new(3, "1-1-2018", "1-1-2015", 0.8)}.must_raise ArgumentError
      begin
        Hotel_System::Block.new(3, "1-1-2018", "1-1-2015", 0.8)
      rescue ArgumentError => e
        e.message.must_equal("Invalid check out date")
      end
    end

    it "checks the block check out date is after the block check in date" do
      proc {Hotel_System::Block.new(3, "10-10-2018", "10-9-2018", 0.8)}.must_raise ArgumentError
      begin
        Hotel_System::Block.new(3, "10-10-2018", "10-9-2018", 0.8)
      rescue ArgumentError => e
        e.message.must_equal("Invalid date range")
      end
    end

    it "checks the block check in date is not the same as the block check out date" do
      proc {Hotel_System::Block.new(3, "10-10-2017", "10-10-2017", 0.8)}.must_raise ArgumentError
      begin
        Hotel_System::Block.new(3, "10-10-2017", "10-10-2017", 0.8)
      rescue ArgumentError => e
        e.message.must_equal("Check out must be after check in")
      end
    end

end
