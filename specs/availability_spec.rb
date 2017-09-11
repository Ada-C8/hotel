require_relative 'spec_helper'

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

    it "the calendar contains 366 hashes representing the current day and each day of the next year" do
      @all_availability[0].must_be_instance_of Hash
      @all_availability[0].keys[0].must_be_instance_of Date
      @all_availability[125].keys[0].must_be_instance_of Date
      @all_availability[362].keys[0].must_be_instance_of Date
      @all_availability.count.must_equal 366
    end

    it "shows each day for year including and following the day the availability is called" do
      date = Date.today
      nextyear = date + 365
      @all_availability[0].keys[0].must_equal date
      print @all_availability.count
      @all_availability[365].keys[0].must_equal nextyear
    end
  end

  describe "all available rooms method" do
    it "returns an array of room ids" do
      all_availability = Availability.all_available_rooms(2017, 9, 28, 2017, 9, 29)
      all_availability.must_be_instance_of Array
      all_availability[0].must_be_instance_of Integer
    end
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

    describe "all blocked rooms method" do
      it "returns an array of room ids" do
        Block.new(4, 2017, 10, 18, 2017, 10, 21, "Smith")
        blocks = Availability.all_blocked_rooms(2017, 10, 18)
        blocks.must_be_instance_of Array
        blocks.count.must_equal 4
      end

      it "returns an empty array if there are no blocks on that day" do
        blocks = Availability.all_blocked_rooms(2017, 10, 28)
        blocks.must_be_instance_of Array
        blocks.count.must_equal 0
      end
    end

    describe "block available rooms method" do
      it "returns the number of remaining rooms in a block" do

      end

      it "returns an error if a block ID is entered that doesn't exist" do

      end

      
    end

  def teardown
    Availability.set_calendar([])
  end

end
