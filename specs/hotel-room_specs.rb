require_relative 'spec_helper.rb'

describe "Hotel::Room" do
  describe "Room instantiation" do
    it "can initialize a room" do
      Hotel::Room.new(1).must_be_instance_of Hotel::Room
    end

    it "can't create a room that is greater or lesser than number of rooms" do
      proc{ Hotel::Room.new(0)}.must_raise ArgumentError
      proc{ Hotel::Room.new(100)}.must_raise ArgumentError
    end

    it "responds to number" do
      room = Hotel::Room.new(1)
      room.must_respond_to :number
      room.number.must_be_instance_of Integer
      room.number.must_equal 1
    end

    it "can make a hotel of rooms" do
      hotel = Hotel::Room.all
      hotel.must_be_instance_of Array
      20.times do |i|
        hotel[i].must_be_instance_of Hotel::Room
      end
    end

    it "can make a list of rooms" do
      Hotel::Room.must_respond_to :list_all
      hotel = Hotel::Room.all
      Hotel::Room.list_all.must_be_instance_of Array
      hotel_list = Hotel::Room.list_all
      20.times do |i|
        hotel_list[i].must_be_instance_of Hotel::Room
      end
    end

  end
end
