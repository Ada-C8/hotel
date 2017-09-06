require_relative 'spec_helper.rb'

describe "Hotel_System::Hotel" do

  it "can initialize a new hotel" do
    hotel = Hotel_System::Hotel.new(20)
    hotel.must_be_instance_of Hotel_System::Hotel
  end

  it "adds the correct number of rooms to a new hotel" do
    hotel = Hotel_System::Hotel.new(20)
    hotel.all_rooms.length.must_equal 20
  end

  it "hotel is an array of room objects" do
    hotel = Hotel_System::Hotel.new(20)
    hotel.all_rooms.each do |room|
      room.must_be_instance_of Hotel_System::Room
    end
  end

it "can access room number from room object" do
  hotel = Hotel_System::Hotel.new(20)
  hotel.room_number(0).must_equal 1
  hotel.room_number(19).must_equal 20
end

it "list_of_rooms returns list of all hotel rooms" do
  hotel = Hotel_System::Hotel.new(20)
  hotel.list_of_rooms.must_be_instance_of Array
  hotel.list_of_rooms.length.must_equal 20
  hotel.list_of_rooms[0].must_equal 1
  hotel.list_of_rooms[19].must_equal 20
end

it "can store a list of reservations" do
hotel = Hotel_System::Hotel.new(20)

end

end
