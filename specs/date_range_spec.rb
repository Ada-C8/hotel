require_relative 'spec_helper'
require 'date'

describe "DateRange" do
  before do
    checkin_day = Date.new(2017, 9, 5)
    checkout_day = Date.new(2017, 9, 7)

    @date_range = Hotel::DateRange.new(checkin_day, checkout_day)
  end # before

  describe "initialize" do
    it "can create a new instance of the DateRange class" do
      @date_range.must_be_kind_of Hotel::DateRange
    end # it "can create a new instance of the DateRange class" do

    it "must have a stating date and ending date that are instances of the date class" do
      @date_range.start_date.must_be_kind_of Date
      @date_range.end_date.must_be_kind_of Date
    end #it "must have a stating date and ending date that are instances of the date class"

    it "must create num_nights as an integerer that is equal to the number of nights " do
      @date_range.num_nights.must_be_kind_of Integer
      @date_range.num_nights.must_equal 2
    end # it "must create num_nights as an integer" do
  end # initialize
    describe "nights_booked" do

    it "must create a array of the days where the room is occupied for the night" do
      day_2 = @date_range.start_date + 1

      @date_range.nights_booked.must_be_kind_of Array
      @date_range.nights_booked.must_equal [@date_range.start_date, day_2]
      @date_range.nights_booked[0].must_be_kind_of Date
      @date_range.nights_booked[1].must_be_kind_of Date
      @date_range.nights_booked.length.must_equal 2
    end # it "must create a array of the days where the room is occupied for the night" do
  end # nights booked

end # DateRange
