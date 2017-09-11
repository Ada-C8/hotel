require_relative 'spec_helper'

describe 'Booking' do
  before do
    @new_booking = Hotel::Booking.new("2017-09-21", "2017-09-23")
  end
  describe 'initialize' do
    it "must be an instance of Booking" do
      @new_booking.must_be_instance_of Hotel::Booking
    end
    it "must have a check in date" do
      @new_booking.must_respond_to :check_in
    end
    it "must have a check out date" do
      @new_booking.must_respond_to :check_out
    end
    it "must have a room number" do
      @new_booking.must_respond_to :room_number
    end
  end

  describe "check in date" do
    it "must be a date" do
      @new_booking.check_in.must_be_kind_of Date
    end
    it "must output the correct date" do
      @new_booking.check_in.must_equal Date.parse("2017-09-21")
    end
  end

  describe "check out date" do
    it "must be a date do" do
      @new_booking.check_out.must_be_kind_of Date
    end
    it "must output the correct date" do
      @new_booking.check_out.must_equal Date.parse("2017-09-23")
    end
  end

  describe "room number" do
    it "must be an integer" do
      @new_booking.room_number.must_be_kind_of Integer
    end
  end
end


describe 'DateRange' do
  before do
    @new_date_range = Hotel::DateRange.new("2019-01-01", "2019-01-04")
  end
  describe 'initialize' do
    it 'will initialize' do
      @new_date_range.must_be_instance_of Hotel::DateRange
    end
  end
  describe 'dates method' do
    it 'is an array' do
      @new_date_range.dates.must_be_kind_of Array
    end
    it 'must include the correct number of dates' do
      @new_date_range.dates.length.must_equal 4
    end
  end
end
