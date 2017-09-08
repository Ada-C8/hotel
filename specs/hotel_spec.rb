require_relative 'spec_helper'

describe "HotelClass" do
  before do
    @hotel_test = Hotel::HotelClass.new
  end
  describe "Initialize Hotel Class" do
    it "HotelClass.new is an instance of Hotel module" do
      @hotel_test.must_be_instance_of Hotel::HotelClass
    end
    it "Responds to rooms variable" do
      @hotel_test.must_respond_to :rooms
    end
    it "Rooms variable is an array" do
      @hotel_test.rooms.must_be_kind_of Array
    end
    it "Rooms variable has 20 rooms" do
      @hotel_test.rooms.length.must_equal 20
    end
  end

  describe "Reserve_room method" do
    it "Responds to Hotel::Reservation" do
      @hotel_test.reserve_room(2,"2017-9-12", "2017-9-15")
      @hotel_test.reservations[0].must_be_instance_of Hotel::Reservation
    end
  end
  describe "Access_reservations method" do
    it "Responds to HotelClass" do
      @hotel_test.must_respond_to :reservations
    end
    it "Is an Array" do
      @hotel_test.reserve_room(2,"2017-9-12", "2017-9-15")
      @hotel_test.access_reservations.must_be_kind_of Array
    end
    it "Has one element" do
      @hotel_test.reserve_room(2,"2017-9-12", "2017-9-15")
      @hotel_test.access_reservations.length.must_equal 1
    end
  end
end
