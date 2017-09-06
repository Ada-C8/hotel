require_relative 'spec_helper'


describe "Hotel" do
  describe "DateRange" do

    before do
      checkin = Date.new(2017,9,5)
      checkout = Date.new(2017,9,7)
      @trip = Hotel::DateRange.new(checkin, checkout)
    end

    it "dates will be numbers" do
      @trip.must_respond_to :checkin
      @trip.must_respond_to :checkout
      @trip.must_respond_to :total_nights
    end

    it "raises error if given invalid date" do
      checkin = Date.new(2017,9,8)
      checkout = Date.new(2017,9,7)
      @error_night = Hotel::DateRange.new(checkin, checkout)
      proc {@error_night.check_valid}.must_raise StandardError
    end

    it "dates will be a date" do
      @trip.checkin.must_be_kind_of Date
    end

    it "will count total nights" do
      # binding.pry
      @trip.total_nights.must_equal 2
    end

    it "array of nights will be created" do
      @trip.night_array.must_be_kind_of Array
      @trip.make_nights_array.must_be_kind_of Array
      # @trip.night_array.must_include [(2017)]
    end

    # wrong date order
    # wrong date entry
    # wrong room number

    # checkin = Date.new(2017,9,5)
    # checkout = Date.new(2017,9,7)
    # # Booking.new(checkin, checkout)
    # total_nights = checkout - checkin
    # total_nights.to_i
  end
end
