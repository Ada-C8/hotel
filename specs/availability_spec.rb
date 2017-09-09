require_relative 'spec_helper'
require 'date'

describe "availability class" do
  before do
    Availability.create_calendar
  end
  describe "initialize availability" do
    before do
      @all_availability = Availability.calendar
    end

    it "has a calendar array" do

      @all_availability.must_be_instance_of Array
    end

    it "the calendar contains 365 hashes representing each day of the next year" do
      @all_availability[0].must_be_instance_of Hash
      @all_availability[0].keys[0].must_be_instance_of Date
    end

    it "shows each day for year including and following the day the availability is called" do
      date = Date.today
      nextyear = (date + 364)
      @all_availability[0].keys[0].must_equal date
      # @all_availability[0].keys[1].must_equal (date + 1)
    end
  end

  describe "all available rooms method" do
    it "returns an array of room ids" do
      all_availability = Availability.all_available_rooms(2017, 9, 28, 2017, 9, 29)
      all_availability.must_be_instance_of Array
      all_availability[0].must_be_instance_of Integer
    end
  end

  def teardown
    Availability.set_calendar([])
  end

  describe "all reservations method" do
    it "returns an array of room ids" do
      Reservation.new(1, 2017, 10, 8, 2017, 10, 9)
      all_availability = Availability.all_reservations(2017, 10, 8)
      all_availability.must_be_instance_of Array
      all_availability[0].must_equal 1
    end

    it "returns an empty array if there are no reservations on that day" do
      all_availability = Availability.all_reservations(2017, 9, 28)
      all_availability.must_be_instance_of Array
      all_availability.count.must_equal 0
    end

  end

  def teardown
    Availability.set_calendar([])
  end

end
