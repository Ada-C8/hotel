require_relative 'spec_helper'
require 'awesome_print'

describe "Hotel" do
  before do
    @hotel_test = Hotel::Hotel.new
  end
  describe "Initialize Hotel Class" do
    it "Hotel.new is an instance of Hotel module" do
      @hotel_test.must_be_instance_of Hotel::Hotel
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
      @hotel_test.reserve_room(3,"2017-11-12", "2017-11-15")
      @hotel_test.reservations[0].must_be_instance_of Hotel::Reservation
    end
    it "Raises an error if asked to reserve an unavailable room " do
      @hotel_test.reserve_room(3,"2017-11-12", "2017-11-15")
      proc {
        @hotel_test.reserve_room(3,"2017-11-13", "2017-11-15")
      }.must_raise ArgumentError
    end
    it "Raises an error if room does not exist" do
      proc {
        @hotel_test.reserve_room(23,"2017-11-13", "2017-11-15")
      }.must_raise ArgumentError
    end
  end
  describe "Access_reservations method" do
    it "Responds to Hotel" do
      @hotel_test.must_respond_to :reservations
    end
    it "Is an Array" do
      @hotel_test.reserve_room(3,"2017-11-12", "2017-11-15")
      @hotel_test.access_reservations("2017-11-12").must_be_kind_of Array
    end
    it "Has one element" do
      @hotel_test.reserve_room(20,"2017-11-12", "2017-11-15")
      @hotel_test.reserve_room(20,"2017-11-16", "2017-11-20")
      skip
      @hotel_test.access_reservations("2017-11-12").length.must_equal 1
    end
  end
  describe "View_available_rooms method" do
    it "Return a list of available rooms for a given date range" do
      @hotel_test.reserve_room(19,"2017-11-15", "2017-11-18")
      @hotel_test.view_available_rooms("2017-11-15", "2017-11-18").must_be_kind_of Array
      @hotel_test.view_available_rooms("2017-11-15", "2017-11-18").wont_include 19
    end
  end
end
