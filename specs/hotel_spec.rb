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

    it "can create an array to hold reservations" do
      Hotel::Hotel.reservations.must_be_kind_of Array
    end #array
  end #Instantiation

  # describe "Make Reservation" do
  #   it "Can call the Reservation Class:" do
  #     Hotel::Hotel.make_reservation(2222, 2, "2012/12/12", "2012/12/15").must_be_kind_of Reservation
  #   end #call class
  # end #reservations

end #admin
