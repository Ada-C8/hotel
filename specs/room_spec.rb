require_relative 'spec_helper'

describe "Room Class" do


  it "Can instantiate a room" do

    new_room = HotelManagment::Room.new(1)
    new_room.must_be_instance_of HotelManagment::Room

  end

  it "room_number should be an integer" do
    new_room = HotelManagment::Room.new(1)
    # new_room.must_be_instance_of HotelManagment::Room
    new_room.room_number.must_be_instance_of Integer
  end

  it "Room number should be equal to 1" do
    new_room = HotelManagment::Room.new(1)
    new_room.room_number.must_equal 1
  end

  it "rate should be equal to 200" do
    HotelManagment::Room::RATE.must_equal 200
  end

end
