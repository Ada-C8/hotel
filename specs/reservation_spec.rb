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
      room_rate = 200
      checkin_date = Date.new(2001,2,3)
      checkout_date = Date.new(2001,2,14)
      num_nights = checkout_date - checkin_date
      total_cost = num_nights * room_rate
      total_cost.must_equal 2200
    end

    it "return a total_cost of 0 if there is no reservation or invalid date" do
      room_rate = 200
      checkin_date = Date.new()
      checkout_date = Date.new()
      num_nights = checkout_date - checkin_date
      total_cost = num_nights * room_rate
      total_cost.must_equal 0
    end
  end
end
