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

  describe "available room" do
    it "provides an instance of the first available room" do
      pikachu_requests = Hotel::Reservation.new
      pikachu_requests.available_room.must_be_instance_of Hotel::Room
      pikachu_requests.available_room.num.must_equal 1
    end
  end

  describe "reserve room" do
    it "creates a reservation" do
      ash_says = Hotel::Reservation.new
      d = ash_says.date_range("10-1-2017","10-5-2017")
      num = ash_says.available_room
      ash_says.reserve_room(d, num).must_be_instance_of Array
    end
    it "adds to reservations array" do
      oddish_asks = Hotel::Reservation.new
      oddish_asks.reservations.length.must_equal 0
      d = oddish_asks.date_range("10-1-2017","10-5-2017")
      num = oddish_asks.available_room
      oddish_asks.reserve_room(d, num)
      oddish_asks.reservations.length.must_equal 1
    end
  end

  describe "total" do
    it "returns the total cost of the stay" do
      charizard_chars = Hotel::Reservation.new
      d = charizard_chars.date_range("12-5-2017","12-10-2017")
      num = charizard_chars.available_room
      charizard_chars.reserve_room(d, num)
      charizard_chars.total.must_equal "$1000.00"
    end
    it "returns $200 if the stay was one night" do
      charizard_chars = Hotel::Reservation.new
      d = charizard_chars.date_range("12-5-2017","12-6-2017")
      num = charizard_chars.available_room
      charizard_chars.reserve_room(d, num)
      charizard_chars.total.must_equal "$200.00"
    end
    it "returns $0 if the stay was zero nights" do
      charizard_chars = Hotel::Reservation.new
      d = charizard_chars.date_range("12-5-2017","12-5-2017")
      num = charizard_chars.available_room
      charizard_chars.reserve_room(d, num)
      charizard_chars.total.must_equal "$0.00"
    end
  end



end
