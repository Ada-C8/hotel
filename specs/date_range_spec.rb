require 'pry'
require_relative 'spec_helper'

describe "DateRange Class" do
  # before do
  #   @date = Hotel::DateRange.new
  # end #before

  describe "Instantiation" do
    before do
      @test = Hotel::DateRange.new
    end
    it "can instantiate a DateRange class" do
      Hotel::DateRange.new.must_be_kind_of Hotel::DateRange
    end #admin class

    # it "can create a hash of rooms" do
    #   @test_hotel.rooms.must_be_kind_of Hash
    # end #rooms
  end #Instantiation
end #admin
