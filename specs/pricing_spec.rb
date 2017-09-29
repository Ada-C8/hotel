require_relative 'spec_helper'

describe Hotel::Pricing do
  describe "method self.calc_cost(reservation)" do
    it "returns a float value" do
      reservation = Hotel::Reservation.new("guest", Date.new(2018, 11, 12), Date.new(2018, 11, 13), Hotel::Room.new(2))
      Hotel::Pricing.calc_cost(reservation).must_be_kind_of Float
    end

    it "calculates the cost of one night to be 200" do
      reservation = Hotel::Reservation.new("guest", Date.new(2018, 11, 12), Date.new(2018, 11, 13), Hotel::Room.new(5))

      Hotel::Pricing.calc_cost(reservation).must_equal 200
    end

    it "accurately calculates the cost of multiple night reservations" do
      reservation = Hotel::Reservation.new("guest", Date.new(2018, 11, 12), Date.new(2018, 11, 14), Hotel::Room.new(18))

      res2 = Hotel::Reservation.new("guest", Date.new(2018, 11, 12), Date.new(2018, 11, 20), Hotel::Room.new(8) )


      Hotel::Pricing.calc_cost(reservation).must_equal 400

      Hotel::Pricing.calc_cost(res2).must_equal 1600
    end

    it "returns a discounted value if room is reserved in a block" do
      reservation = Hotel::Reservation.new("guest", Date.new(2018, 11, 12), Date.new(2018, 11, 14), Hotel::Room.new(18), 123456)

      Hotel::Pricing.calc_cost(reservation).must_equal 360
    end


  end


end
