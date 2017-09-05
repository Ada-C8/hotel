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

  

end
