require_relative 'spec_helper'
require 'awesome_print'

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
      @hotel_test.reserve_room(3,"2017-9-12", "2017-9-15")
      @hotel_test.reservations[0].must_be_instance_of Hotel::Reservation
    end
    it "Raises an error if asked to reserve an unavailable room " do
      skip
      @hotel_test.reserve_room(3,"2017-9-12", "2017-9-15")
      proc {
        @hotel_test.reserve_room(3,"2017-9-13", "2017-9-15")
      }.must_raise ArgumentError
    end
  end
  describe "Access_reservations method" do
    it "Responds to HotelClass" do
      @hotel_test.must_respond_to :reservations
    end
    it "Is an Array" do
      @hotel_test.reserve_room(3,"2017-9-12", "2017-9-15")
      @hotel_test.access_reservations("2017-9-12").must_be_kind_of Array
    end
    it "Has one element" do
      @hotel_test.reserve_room(3,"2017-9-12", "2017-9-15")
      @hotel_test.reserve_room(3,"2017-9-16", "2017-9-20")
      @hotel_test.access_reservations("2017-9-12").length.must_equal 2
    end
  end
  describe "View_available_rooms method" do
    it "Return a list of available rooms for a given date range" do
      hotel_test2 = Hotel::HotelClass.new
      hotel_test2.reserve_room(2,"2017-9-15", "2017-9-18")
      hotel_test2.reserve_room(3,"2017-9-15", "2017-9-18")
      hotel_test2.reserve_room(1,"2017-9-15", "2017-9-18")

      hotel_test2.view_available_rooms("2017-9-15", "2017-9-18").must_be_kind_of Array
      hotel_test2.view_available_rooms("2017-9-15", "2017-9-18").must_include 5
    end
  end
end
