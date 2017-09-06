require_relative './spec_helper'
require_relative '../lib/reservations'

describe "#RESERVATION" do
  before do
    @room = Room.new(1, 200)
    @new_reservation = Reservation.new("January 16, 2018", "January 18, 2018", @room)
    @new_reservation1 = Reservation.new("15-05-2018", "22-05-2018", @room)
  end

  it "An Administrator can initialize an instance of Reservation for a room" do
    @new_reservation.must_be_instance_of Reservation
    @new_reservation.check_in.must_be_instance_of Date
    @new_reservation.check_out.must_be_instance_of Date
    @new_reservation.room_number.must_equal 1
    @new_reservation.must_respond_to :reservation_id

  end

  it "Can accurately report the number of nights in a reservation" do
    @new_reservation.num_nights.must_equal 2
  end

  it "Raises an Argument error for invalid input" do
    proc {Reservation.new("yesterday", "tomorrow", @room)}.must_raise ArgumentError

    proc {Reservation.new("tomorrow", "today", @room)}.must_raise ArgumentError

    proc {Reservation.new("gibberish", "hey", @room)}.must_raise ArgumentError

    proc{Reservation.new("today", "tomorrow", @room)}.must_raise ArgumentError

    proc{Reservation.new("01-18-2018", "01-18-2018", @room)}.must_raise ArgumentError
  end

  it "can calculate the cost for a reservation" do
    @new_reservation.bill.must_equal 400
    @new_reservation1.bill.must_equal 1400
  end

  it "can show all nights in the reservation date range" do
    @new_reservation.nights.must_equal ["2018-01-16", "2018-01-17"]
    @new_reservation1.nights.length.must_equal 7
  end
end
