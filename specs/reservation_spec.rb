require_relative "spec_helper"

describe "reservation class" do
  describe "initialize" do
    it "exists" do
    Hotel::Reservation.new.must_be_instance_of Hotel::Reservation
    end
  end
  describe "date range" do
    it "creates an array of dates" do
      make_date = Hotel::Reservation.new
      make_date.date_range("12-5-2017","12-10-2017").must_be_instance_of Array
      make_date.date_range("12-5-2017","12-10-2017").length.must_equal 6
    end
    it "takes in a starting and ending date" do
      make_date = Hotel::Reservation.new
      dates = make_date.date_range("12-5-2017","12-10-2017")
      dates.must_be_instance_of Array
      dates[0].must_be_kind_of String
    end
  end
  xdescribe "reserve room" do
    it "creates an array of dates" do
      make_date = Hotel::Reservation.new("12-5-2017","12-10-2017")
      make_date.reserve_room.must_be_kind_of Array
      make_date.reserve_room.length.must_equal 6
    end

  end

  xdescribe "total" do
    it "returns the total cost of the stay" do
      make_date = Hotel::Reservation.new("12-5-2017","12-10-2017")
      make_date.total.must_equal "$1000.00"
    end
    it "returns $200 if the stay was one night" do
      make_date = Hotel::Reservation.new("12-5-2017","12-6-2017")
      make_date.total.must_equal "$200.00"
    end
    it "returns $0 if the stay was zero nights" do
      make_date = Hotel::Reservation.new("12-5-2017","12-5-2017")
      make_date.total.must_equal "$0.00"
    end
  end

  xdescribe "available room" do
    it "presents an array of available rooms" do
      make_date = Hotel::Reservation.new("12-5-2017","12-5-2017")
      make_date.available_room.must_be_instance_of Array
      make_date.available_room.length.must_equal 20
    end
    it "removes room from list if it is not available" do
      make_date = Hotel::Reservation.new("12-5-2017","12-6-2017")
      make_date.available_room.length.must_equal 20
      make_date.reserve_room
      make_date.available_room.length.must_equal 19

      #make_date2 = Hotel::Reservation.new("12-4-2017","12-8-2017")

      #make_date2.available_room.length.must_equal 19
    end
  end
  xdescribe "reserve room" do

  end


end
