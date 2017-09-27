require_relative 'spec_helper.rb'
require 'date'

describe "Hotel_System::Reservations" do
  before do
    @hotel = Hotel_System::Hotel.new(20)
    # @room1 = @hotel.return_room_object_by_num(1)
    # @room10 = @hotel.return_room_object_by_num(10)
  end

  it "can initialize a new reservation" do
    reservation = Hotel_System::Reservations.new(1, "1-1-2018", "1-5-2018")
    reservation.must_be_instance_of Hotel_System::Reservations
  end

  it "accepts an appropriate check in date" do
    reservation = Hotel_System::Reservations.new(1, "1-1-2018", "1-5-2018")
    reservation.check_in.must_be_instance_of Date
    reservation.check_in.strftime("%Y-%m-%d").must_equal("2018-01-01")
  end

  it "accepts and appropriate check out date" do
    reservation = Hotel_System::Reservations.new(1, "1-1-2018", "1-5-2018")
    reservation.check_out.must_be_instance_of Date
    reservation.check_out.strftime("%Y-%m-%d").must_equal("2018-05-01")
  end

  it "valid date ranges will pass valid_date_range?" do
    reservation = Hotel_System::Reservations.new(5, "1-1-2018", "1-5-2018")
    reservation.wont_equal ArgumentError
  end

  it "checks that the check in date is not in the past" do
    proc { Hotel_System::Reservations.new(11, "1-1-2015", "1-1-2018")}.must_raise ArgumentError
    begin Hotel_System::Reservations.new(11, "1-1-2015", "1-1-2018")
    rescue ArgumentError => e
      e.message.must_equal("Invalid check in date")
    end
  end

  it "checks the check out date is not in the past" do
    proc {Hotel_System::Reservations.new(1, "1-1-2018", "1-1-2015")}.must_raise ArgumentError
    begin Hotel_System::Reservations.new(1, "1-1-2018", "1-1-2015")
    rescue ArgumentError => e
      e.message.must_equal("Invalid check out date")
    end
  end

  it "checks the check out date is after the check in date" do
    proc {Hotel_System::Reservations.new(20, "10-10-2018", "10-9-2018")}.must_raise ArgumentError
    begin Hotel_System::Reservations.new(20, "10-10-2018", "10-9-2018")
    rescue ArgumentError => e
      e.message.must_equal("Invalid date range")
    end
  end

  it "checks the check in date is not the same as the check out date" do
    proc {Hotel_System::Reservations.new(13, "10-10-2017", "10-10-2017")}.must_raise ArgumentError
    begin Hotel_System::Reservations.new(13, "10-10-2017", "10-10-2017")
    rescue ArgumentError => e
      e.message.must_equal("Check out must be after check in")
    end
  end

  it "correctly calculates the number of nights of the stay" do
    reservation = Hotel_System::Reservations.new(12, "2018-1-1", "2018-1-5")
    reservation.num_of_nights.must_equal 4
    reservation2 = Hotel_System::Reservations.new(5, "2017-12-25", "2018-1-4")
    reservation2.num_of_nights.must_equal 10
  end

  it "correctly calculates the total cost for a reservation" do
    room = Hotel_System::Room.new(2, 200)
    reservation = Hotel_System::Reservations.new(room, "2018-1-1", "2018-1-5")
    reservation.total_cost.must_equal 800
    reservation2 = Hotel_System::Reservations.new(room, "2017-12-25", "2018-1-4")
    reservation2.total_cost.must_equal 2000
  end

  describe "date range generator" do
    it "creates an array of date objects" do
      reservation = Hotel_System::Reservations.new(1, "2018-1-1", "2018-1-5")
      list = reservation.res_date_range_generator
      list.must_be_instance_of Array
      list.length.must_equal 4
    end

  end

end
