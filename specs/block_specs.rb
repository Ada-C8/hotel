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

end
