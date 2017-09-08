require_relative 'spec_helper'

describe "Reservation" do
  describe "initialize" do
    it "creates an instance of Reservation" do
      checkin_date = Date.new(2001,2,3)
      checkout_date = Date.new(2001,2,14)
      date = Hotel::Reservation.new(checkin_date, checkout_date)
      date.must_be_instance_of Hotel::Reservation
    end
  end

  describe "total cost" do
    it "calculates the total cost for reservation made" do
      checkin_date = Date.new(2001,2,3)
      checkout_date = Date.new(2001,2,14)
      date = Hotel::Reservation.new(checkin_date, checkout_date)
      num_nights = checkout_date - checkin_date
      total_cost = (num_nights - 1) * 200
      # puts total_cost
      # puts date.price_night
      date.price_night.must_equal total_cost
    end
  end
  #   it "returns list of all the rooms in the hotel" do
  #
  #
end # end of describe block
