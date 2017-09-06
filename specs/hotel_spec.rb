require_relative 'spec_helper'

describe "Hotel" do
  before do
    @new_hotel = BookingSystem::Hotel.new(20)
  end
  describe "#initialize" do
    it "@rooms should be kind of array" do
      @new_hotel.rooms.must_be_kind_of Array
    end
    it "Should return an array of the rigth length" do
      @new_hotel.rooms.length.must_equal 20
    end
    it "Each room should be kind of integer" do
      @new_hotel.rooms[5].must_be_kind_of Integer
    end
    it "All_reservations must be kind of array" do
      @new_hotel.all_reservations.must_be_kind_of Array
    end
  end

  describe "#room unavailable" do
    it "Returns an array of dates for given room number" do
      @new_hotel.room_unavailable(5).must_be_kind_of Array
    end
    it "Returns empty array if no reservations were made for given room number" do
      @new_hotel.room_unavailable(5).length.must_equal 0
    end
  end


end #end of describe
