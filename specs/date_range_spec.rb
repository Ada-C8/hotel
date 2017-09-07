#require 'pry'
require_relative 'spec_helper'

describe "DateRange Class" do
  before do
    @date_test = Hotel::DateRange.new
  end #before

  describe "Instantiation" do
    before do
      @test = Hotel::DateRange.new
    end

    it "can instantiate a DateRange class" do
      Hotel::DateRange.new.must_be_kind_of Hotel::DateRange
    end #instantiate DateRange

    # it "can create a hash of rooms" do
    #   @test_hotel.rooms.must_be_kind_of Hash
    # end #rooms
  end #Instantiation

  describe "Check In, Check Out, and Range Objects" do
    it "can create a date object for a check in date: " do
      Hotel::DateRange.check_in("2001/1/1").must_be_kind_of Date
    end #check in

    it "can create a date object for a check out date: " do
      Hotel::DateRange.check_out("2001/1/10").must_be_kind_of Date
    end #check_out

    it "can create an array of dates between the check-in and check out" do
      Hotel::DateRange.create_range.must_be_kind_of Array
    end #date_range
  end #check_in, check_out, range

end #DateRange
