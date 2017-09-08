#require 'pry'
require_relative 'spec_helper'


describe "Hotel Class" do
  before do
    @hotel = Hotel::Hotel.new
  end #before

  describe "Instantiation" do
    before do
      @test_hotel = Hotel::Hotel.new
    end

    it "can instantiate a Hotel class" do
      Hotel::Hotel.new.must_be_kind_of Hotel::Hotel
    end #admin class

    it "can create a hash of rooms" do
      @test_hotel.all_rooms.must_be_kind_of Hash
    end #rooms
  end #Instantiation

  # describe "Access Room List" do
  #   # it "Can show a list of all rooms in the hotel" do
  #   #   @hotel.show_roo
  #   # end
  #
  # end #Room List

  describe "Make Reservations" do
    it "can call Reservation List to create an array to hold reservations" do
      @hotel.reservations.must_be_kind_of Hotel::ReservationList
      @hotel.reservations.reservation_list.must_be_kind_of Array
    end #array

    it "Can make a Reservation by calling Reservation List:" do
      @hotel.make_reservation(2222, 2, "2012/12/12", "2012/12/15")
      @hotel.reservations.reservation_list[0].must_be_kind_of Hotel::Reservation
    end #call class

    it "Can check if a room is available before making a reservation for that room " do
      @hotel.make_reservation(2222, 2, "2012/12/12", "2012/12/15")
      @hotel.make_reservation(2224, 10, "2012/12/13", "2012/12/17")
      @hotel.is_available?(1000, 4, "2012/12/13", "2012/12/19").must_equal true
    end
  end #make reservations

  describe "Find Reservations" do
    it "Can find and return a single reservation for a specific date: " do
      @hotel.make_reservation(2222, 2, "2012/12/12", "2012/12/15")
      found = @hotel.find_reservation("2012/12/12", "2012/12/13")
      found[0].view_reservation.must_equal "ID: 2222, Room: 2, Check in: 2012-12-12, Check Out: 2012-12-15, Total Nights: 3, Total Cost: 600"
    end #find a single reservation for a specific date

    it "Can return an array of open rooms for a particular date range: " do
      @hotel.make_reservation(2222, 2, "2012/12/12", "2012/12/15")
      @hotel.make_reservation(2224, 10, "2012/12/13", "2012/12/17")
      @hotel.open_rooms("2012/12/12", "2012/12/13").must_be_kind_of Array
      @hotel.open_rooms("2012/12/12", "2012/12/13")[0].must_equal 1
    end #open rooms

  end #find reservations

  describe "Total Cost" do
    it "Given an ID number it can find the Total Cost of a reservation: " do
      @hotel.make_reservation(2222, 2, "2012/12/12", "2012/12/15")
      @hotel.total_cost(2222).must_equal 600
    end #ID Number

    it "Returns 'Reservation Not Found' if it can't find the ID number: " do
      @hotel.make_reservation(2222, 2, "2012/12/12", "2012/12/15")
      @hotel.total_cost(2223).must_equal "Reservation Not Found"
    end #Not Found
  end #Total Cost

end #admin
