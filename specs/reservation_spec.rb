require_relative 'spec_helper'

require 'date'

describe "Reservation" do
let(:smith) { Hotel::Reservation.new("10-01-2017", "10-04-2017", 2) }

  describe "initialize" do
    it "has a date range" do
      smith.must_respond_to :checkin
      smith.must_respond_to :checkout
      smith.checkin.must_be_instance_of Date
      smith.checkin.must_equal Date.new(2017, 10, 1)
      smith.checkout.must_equal Date.new(2017, 10, 4)
    end

    it "has a room" do
      smith.room.must_equal 2
    end

    it "has a cost" do
      smith.must_respond_to :cost
      smith.cost.must_equal 600
    end

    it "raises an error when given an incorrect date range" do
      proc { Hotel::Reservation.new("10-02-2017", "09-30-2017", 3) }.must_raise ArgumentError

      proc { Hotel::Reservation.new("08-24-2017", "08-31-2017", 3) }.must_raise ArgumentError

      proc { Hotel::Reservation.new("13-30-2017", "03-03-2018", 3) }.must_raise ArgumentError

      proc { Hotel::Reservation.new("02-25-2018", "02-29-2018", 3) }.must_raise ArgumentError
    end
  end
end
