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
    it "throws and error if date is in the past" do
      new_hotel = Hotels::Hotel.new
      proc {new_hotel.check_dates([1970, 9, 10], [2020, 9, 12])}.must_raise ArgumentError
    end

    it "throws and error if end date is before start date" do
      new_hotel = Hotels::Hotel.new
      proc {new_hotel.check_dates([2020, 9, 10], [2000, 9, 12])}.must_raise ArgumentError
    end
    
  end




end
end
