require_relative 'spec_helper'

describe "Testing Hotel class" do
  describe "#initialize" do
    before do
      @hotel = Hotel::Hotel.new
    end

    it "Creates a hotel class with an array of rooms" do
      @hotel.must_be_instance_of Hotel::Hotel

      rooms = @hotel.rooms
      rooms.must_be_instance_of Array

      rooms.each do |room|
        room.must_be_instance_of Hotel::Room
      end
    end

    it "Creates a hotel with NUM_ROOMS num of rooms as the default" do
      @hotel.rooms.length.must_equal Hotel::Hotel::NUM_ROOMS
    end

    it "Creates a hotel with the specified number of rooms" do
      num_rooms = 17
      new_hotel = Hotel::Hotel.new(num_rooms)
      new_hotel.rooms.length.must_equal num_rooms
    end

    it "Raises an error if not passed a valid number for num of rooms" do
      invalid_nums = [-1, 0, "dog", 3.14, nil, ""]

      invalid_nums.each do |item|
        proc { Hotel::Hotel.new(item) }.must_raise ArgumentError
      end
    end

  end
end
