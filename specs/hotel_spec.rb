require_relative 'spec_helper'
# require 'date'


describe "hotel class" do
  describe "initialize hotel" do
    before do
      @hotel = Hotel.new
    end

      it "creates a hotel object" do
        @hotel.must_be_instance_of Hotel
      end

      it "lets you access an array of rooms" do
        @hotel.rooms.must_be_instance_of Array
      end

      it "has 20 room objects" do
        @hotel.rooms.count.must_equal 20
        @hotel.rooms[0].must_be_instance_of Room
        @hotel.rooms[19].must_be_instance_of Room
      end

      it "gives each room a unique ID from 1 to 20" do
        @hotel.rooms[0].id.must_equal 1
        @hotel.rooms[19].id.must_equal 20
        @hotel.rooms[7].id.must_equal 8
      end

      it "gives all rooms a default status of available" do
        @hotel.rooms[0].status.must_equal :available
        @hotel.rooms[19].status.must_equal :available
        @hotel.rooms[9].status.must_equal :available
      end

      it "gives all rooms a default rate of 200" do
        @hotel.rooms[0].rate.must_equal 200
        @hotel.rooms[19].rate.must_equal 200
        @hotel.rooms[9].rate.must_equal 200
      end




  end


end
