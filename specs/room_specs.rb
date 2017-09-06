require_relative 'spec_helper.rb'

describe "Hotel_System::Room" do

  it "can ininitialize room" do
    room = Hotel_System::Room.new(1, 200)
    room.must_be_instance_of Hotel_System::Room
    room.must_respond_to :price
    room.must_respond_to :room_number 
  end

  it "given room must return accurate price" do
    room = Hotel_System::Room.new(1, 200)
    room.price.must_equal 200
  end

  it "given room must return accurate room number" do
    room = Hotel_System::Room.new(1, 200)
    room.room_number.must_equal 1
  end

  # it "can change the price for a given room number" do
  #   hotel = Hotel_System::Hotel.new(20)
  #   hotel.all_rooms[0].room.price.must_equal 200
  # end

end
