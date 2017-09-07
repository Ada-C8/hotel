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
      @test_hotel.reservations.must_be_kind_of Array
    end #array
  end #Instantiation
end #admin
