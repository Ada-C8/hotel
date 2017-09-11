require_relative 'spec_helper'

describe "Reservation" do
  describe "initialize" do
    it "creates an instance of Reservation" do
      name = "bob"
      reserved_rooms = [1,2,3]
      checkin_date = Date.new(2001,2,3)
      checkout_date = Date.new(2001,2,14)
      date_range = Hotel::DateRange.new(checkin_date, checkout_date)
      reservation = Hotel::Reservation.new(name, reserved_rooms[0],date_range)
      reservation.must_be_instance_of Hotel::Reservation
    end
  end

  describe "total cost" do
    it "calculates the total cost for reservation made" do
      checkin_date = Date.new(2001,2,3)
      checkout_date = Date.new(2001,2,14)
      num_nights = checkout_date - checkin_date
      total_cost = num_nights * 200
      total_cost.must_equal 2200
    end
  end
end
