require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/hotel'
require_relative './spec_helper.rb'

describe "Hotel" do
  describe "initialize hotel" do

  it "can initialize hotel" do
    new_hotel = Hotels::Hotel.new
    new_hotel.must_be_instance_of Hotels::Hotel
    new_hotel.reservations.must_be_kind_of Array
    new_hotel.rooms.must_be_instance_of Array
  end

  describe "check_dates" do
    it "can check if date is in the future" do
      new_hotel = Hotels::Hotel.new
      dates = new_hotel.check_dates([2020, 9, 10], [2020, 9, 12])
      dates.must_be_instance_of Array
      dates[0].must_be_instance_of Date

      test_date = Date.new(2020, 9, 10)
      dates[0].must_equal test_date
    end
    it "throws an error if date is in the past" do
      new_hotel = Hotels::Hotel.new
      proc {new_hotel.check_dates([1970, 9, 10], [2020, 9, 12])}.must_raise ArgumentError
    end

    it "throws error if end date is before start date" do
      new_hotel = Hotels::Hotel.new
      proc {new_hotel.check_dates([2020, 9, 10], [2000, 9, 12])}.must_raise ArgumentError
    end
    it "throws an error if dates are not in correct format" do
      new_hotel = Hotels::Hotel.new
      proc {new_hotel.check_dates(["a",10,2020], ["b",3,2000])}.must_raise ArgumentError
      proc {new_hotel.check_dates([1,30,2020], [100,3,2000])}.must_raise ArgumentError
    end
    it "thows an error if start and end date are the same" do
      new_hotel = Hotels::Hotel.new
      proc {new_hotel.check_dates([2020, 9, 10], [2020, 9, 10])}.must_raise ArgumentError
    end
  end

  describe "date_range" do
    it "can create a date range" do
      new_hotel = Hotels::Hotel.new
      dates = new_hotel.check_dates([2020, 9, 10], [2020, 9, 12])
      date_range = new_hotel.date_range(dates)

      date_range.must_be_instance_of Array
      date_range.length.must_equal 2
      
      test_date = Date.new(2020, 9, 11)
      date_range[1].must_equal test_date
    end
  end




end
end
