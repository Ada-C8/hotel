require_relative 'spec_helper'
require 'date'

describe "availability class" do
  describe "initialize availability" do
    before do
      @all_availability = Availability.new
    end

      it "creates an Availability object" do
        @all_availability.must_be_instance_of Availability
      end

      it "has a calendar array" do
        @all_availability.calendar.must_be_instance_of Array
      end

      it "the calendar contains 365 hashes representing each day of the next year" do
        @all_availability.calendar[0].must_be_instance_of Hash
        @all_availability.calendar[0][:date].must_be_instance_of Date
      end

      it "shows each day for year including and following the day the availability is called" do
        date = Date.today
        next_year = Date.today + 365
        @all_availability.calendar[0][:date].must_equal date
        @all_availability.calendar[365][:date].must_equal date + 365
      end

  end

  describe "all available rooms method" do
      before do
        @all_availability = Availability.new
        @test = @all_availability.all_available_rooms(2017,9,8)
      end
    it "returns an array of room ids" do
      @test.must_be_instance_of Array
      print @test.count
      @test[0].must_be_instance_of Integer
    end


  end
end
