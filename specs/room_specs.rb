require_relative 'spec_helper.rb'

describe "Hotel_System::Room" do

  it "can ininitialize room" do
    room = Hotel_System::Room.new(1, 200)
    room.must_be_instance_of Hotel_System::Room
    room.must_respond_to :price
    room.must_respond_to :room_num
  end

  it "given room must return accurate price" do
    room = Hotel_System::Room.new(1, 200)
    room.price.must_equal 200
  end

  it "given room must return accurate room number" do
    room = Hotel_System::Room.new(1, 200)
    room.room_num.must_equal 1
  end

  

end
