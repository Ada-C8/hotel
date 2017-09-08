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

  describe "Make Reservation" do
    it "can create an array to hold reservations" do
      Hotel::Hotel.reservations.must_be_kind_of Array
    end #array

    it "Can make a Reservation by calling the Reservation Class:" do
      a = Hotel::Hotel.make_reservation(2222, 2, "2012/12/12", "2012/12/15")
      a[0].must_be_kind_of Hotel::Reservation
    end #call class
  end #reservations

  # describe "View Reservation" do
  #   it "Can return a reservation for a certain date: " do
  #     a = Hotel::Hotel.make_reservation(2222, 2, "2012/12/12", "2012/12/15")
  #     a.view_reservations.must_
  #   end
  #end

end #admin
