require_relative 'spec_helper'

describe "Room Class" do
  describe ""do

  it "Can instantiate a room" do

    new_room = HotelManagment::Room.new(1, 200)
    new_room.must_be_instance_of HotelManagment::Room

  end

  it "Room rate should be 200" do

    new_room = HotelManagment::Room.new(1, 200)
    new_room.must_be_instance_of HotelManagment::Room
    new_room.rate.must_equal 200

  end
end
end


# As an administrator, I can access the list of all of the rooms in the hotel
# As an administrator, I can get the total cost for a given reservation
