require_relative "spec_helper"

describe "Reservation class" do
  describe "initialize" do
    it "creates an instance of a reserved room" do
      room_number = 1
      date = Hotel::DateRange.new("12-3-2017", "12-5-2017")
      Hotel::Reservation.new(date, room_number).must_be_kind_of Hotel::Reservation
    end
  end
  describe "total" do
    it "returns the total cost of the stay" do
      charizard_num = Hotel::Hotel.new.available_room
      date = Hotel::DateRange.new("12-5-2017","12-10-2017")
      Hotel::Reservation.new(date, charizard_num).total.must_equal "$1000.00"
    end
    it "returns $200 if the stay was one night" do
      charizard_chars = Hotel::Hotel.new
      num = charizard_chars.available_room
      date = Hotel::DateRange.new("12-5-2017", "12-6-2017")
      Hotel::Reservation.new(date, num).total.must_equal "$200.00"
    end
    it "returns $0 if the stay was zero nights" do
      charizard_chars = Hotel::Hotel.new
      num = charizard_chars.available_room
      date = Hotel::DateRange.new("12-5-2017","12-5-2017")
      Hotel::Reservation.new(date, num).total.must_equal "$0.00"
    end
  end
end
#
