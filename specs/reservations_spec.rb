require_relative './spec_helper'
require_relative '../lib/reservations'

describe "#RESERVATION" do
  before do
    @new_reservation = Reservation.new("January 16, 2018", "January 18, 2018", 200)
    @new_reservation1 = Reservation.new("15-05-2018", "22-05-2018", 100)
  end

  it "Can initialize an instance of reservation" do
    @new_reservation.must_be_instance_of Reservation
    @new_reservation.check_in.must_be_instance_of Date
    @new_reservation.check_out.must_be_instance_of Date

  end

  it "Can accurately report the number of nights in a reservation" do
    @new_reservation.nights.must_equal 2
  end

  it "Raises an Argument error for invalid input" do
    proc {Reservation.new("yesterday", "tomorrow")}.must_raise ArgumentError

    proc {Reservation.new("tomorrow", "today")}.must_raise ArgumentError

    proc {Reservation.new("gibberish", "hey")}.must_raise ArgumentError

    proc{Reservation.new("today", "tomorrow")}.must_raise ArgumentError

    proc{Reservation.new("01-18-2018", "01-18-2018")}.must_raise ArgumentError
  end

  it "can calculate the cost for a reservation" do
    @new_reservation.bill.must_equal 400
    @new_reservation1.bill.must_equal 700
  end
end
