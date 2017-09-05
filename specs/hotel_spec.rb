require_relative 'spec_helper'

describe "Hotel" do
  describe "Initialize" do
    it "Can be instantiated" do
      Hotel::Hotel.new(20).must_be_kind_of Hotel::Hotel
    end

    it "Creates an array of rooms" do
      hotel = Hotel::Hotel.new(20)

      hotel.rooms.must_be_kind_of Array
      hotel.rooms.length.must_equal 20
    end
  end
end
