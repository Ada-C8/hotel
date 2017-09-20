require_relative 'spec_helper'

describe "Administration#Reservation" do

  describe "instantiate a reservation" do
    it "has a check_in and check out date and a room" do
      room = 5
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      reservation = Administration::Reservation.new(check_in, check_out, room)

      reservation.must_respond_to :check_in
      reservation.check_in.must_equal check_in
      reservation.check_in.must_be_kind_of Date
    end

    it "raise ArgumentError if there is no overnight stay" do
      room = 5
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 1)

      proc {
        Administration::Reservation.new(check_in, check_out, room)
      }.must_raise ArgumentError
    end

    it "raise ArgumentError if check_in is not a date" do
      room = 5
      check_in = "string"
      check_out = Date.new(2017, 9, 1)

      proc {
        Administration::Reservation.new(check_in, check_out, room)
      }.must_raise ArgumentError
    end

    it "raise ArgumentError if check_out is not a date" do
      room = 5
      check_in = Date.new(2017, 9 , 1)
      check_out = 5

      proc {
        Administration::Reservation.new(check_in, check_out, room)
      }.must_raise ArgumentError
    end

    it "raise ArgumentError if check out date comes before the check in date" do
      room = 5
      check_in = Date.new(2017, 9, 30)
      check_out = Date.new(2017, 9, 1)

      proc {
        Administration::Reservation.new(check_in, check_out, room)
      }.must_raise ArgumentError
    end
  end

  describe "#total_nights" do
    it "return the total number of nights for a date range" do
      room = 5
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      reservation = Administration::Reservation.new(check_in, check_out, room)
      reservation.total_nights.must_equal 4
    end

    it "return the total number of nights when the month and year change" do
      room = 5
      check_in = Date.new(2017, 12, 30)
      check_out = Date.new(2018, 1, 4)
      reservation = Administration::Reservation.new(check_in, check_out, room)
      reservation.total_nights.must_equal 5
    end

    it "return one for a single night" do
      room = 5
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 2)
      reservation = Administration::Reservation.new(check_in, check_out, room)
      reservation.total_nights.must_equal 1
    end
  end #end of total_nights

  describe "#total_cost" do
    it "return the correct product of any number of nights and the rate" do
      room = 5
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      reservation = Administration::Reservation.new(check_in, check_out, room)
      reservation.total_cost.must_equal 800
    end
  end

  describe "#reserved?" do
    it "return true if the target date is in the date range" do
      room = 5
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      reservation = Administration::Reservation.new(check_in, check_out, room)
      reservation.reserved?(Date.new(2017, 9, 3)).must_equal true

      room = 5
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      reservation = Administration::Reservation.new(check_in, check_out, room)
      reservation.reserved?(Date.new(2017, 9, 1)).must_equal true

      room = 5
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      reservation = Administration::Reservation.new(check_in, check_out, room)
      reservation.reserved?(Date.new(2017, 8, 31)).must_equal false
    end

    it "not consider the check out date as a day to charge" do
      room = 5
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      reservation = Administration::Reservation.new(check_in, check_out, room)
      reservation.reserved?(Date.new(2017, 9, 5)).must_equal false
    end
  end

  describe "#overlap?" do
    it "returns false if the reservations do not overlap" do
      room = 5
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      reservation = Administration::Reservation.new(check_in, check_out, room)
      room = 5
      check_in = Date.new(2017, 9, 5)
      check_out = Date.new(2017, 9, 7)
      reservation2 = Administration::Reservation.new(check_in, check_out, room)
      reservation.overlap?(reservation2).must_equal false

      room = 5
      check_in = Date.new(2017, 8, 30)
      check_out = Date.new(2017, 9, 1)
      reservation = Administration::Reservation.new(check_in, check_out, room)
      room = 5
      check_in = Date.new(2017, 8, 28)
      check_out = Date.new(2017, 8, 30)
      reservation2 = Administration::Reservation.new(check_in, check_out, room)
      reservation.overlap?(reservation2).must_equal false
    end

    it "returns true if the reservations overlap" do
      room = 5
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      reservation = Administration::Reservation.new(check_in, check_out, room)
      room = 5
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      reservation2 = Administration::Reservation.new(check_in, check_out, room)
      reservation.overlap?(reservation2).must_equal true
    end

  end


end #end of module
