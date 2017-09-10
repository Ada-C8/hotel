require_relative 'spec_helper'


describe "Hotel" do
  describe "DateRange" do

    before do
      @checkin = Date.new(2017,9,5)
      @checkout = Date.new(2017,9,7)
      @trip = Hotel::DateRange.new(@checkin, @checkout)
    end

    it "dates will be numbers" do
      @trip.must_respond_to :checkin
      @trip.must_respond_to :checkout
      @trip.must_respond_to :total_nights
    end

    it "raises error if given invalid date" do
      checkin = Date.new(2017,9,8)
      checkout = Date.new(2017,9,7)
      proc {Hotel::DateRange.new(checkin, checkout)}.must_raise DateRangeError
    end

    it "dates will be a date" do
      @trip.checkin.must_be_kind_of Date
    end

    it "will count total nights" do
      @trip.total_nights.must_equal 2
    end

    it "array of nights will be created" do
      @trip.night_array.must_be_kind_of Array
      @trip.make_nights_array.must_be_kind_of Array
    end

    it "knows if date is included" do
      @trip.include?(@checkin).must_equal true
    end
  end
end
