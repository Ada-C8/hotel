require_relative 'spec_helper'
require 'date'

describe "DateRangeError class" do

    it "Can be instantiated" do
      BookingSystem::DateRange::DateRangeError.new.must_be_instance_of BookingSystem::DateRange::DateRangeError
    end
end

describe "DateRange class" do

  before do
    check_in = Date.new(2017,9,9)
    check_out = Date.new(2017,9,12)
    @test_ob = BookingSystem::DateRange.new(check_in, check_out)
  end

  describe "intialize method" do

    it "Can be initialized" do
      @test_ob.must_be_instance_of BookingSystem::DateRange
    end

    it "Raises a DateRangeError when an invalid date range is passed" do
      proc { BookingSystem::DateRange.new(Date.new(2017,9,9), Date.new(2017,9,5)) }.must_raise BookingSystem::DateRange::DateRangeError

      proc { BookingSystem::DateRange.new(Date.new(2017,9,5), Date.new(2017,9,5)) }.must_raise BookingSystem::DateRange::DateRangeError
    end

    it "Has an instance variable @check_in that is an instance of Date" do
      @test_ob.check_in.must_be_instance_of Date
    end

    it "Has an instance variable @check_out that is an instance of Date" do
      @test_ob.check_out.must_be_instance_of Date
    end

  end

  describe "all_reservation_dates method" do

    it "Can be called" do
      @test_ob.must_respond_to :all_reservation_dates
    end

    it "Returns an array" do
      @test_ob.all_reservation_dates.must_be_instance_of Array
    end

    it "Returns an array of date objects" do
      @test_ob.all_reservation_dates[0].must_be_instance_of Date

      @test_ob.all_reservation_dates[-1].must_be_instance_of Date
    end

    it "Generates all the dates between @check_in and @check_out (noninclusive)" do
      @test_ob.all_reservation_dates[0].day.must_equal 9
      @test_ob.all_reservation_dates[1].day.must_equal 10
      @test_ob.all_reservation_dates[-1].day.must_equal 11
    end

  end


end
