require_relative 'spec_helper'
require 'date'

describe "reservations class" do
  before do
    Availability.create_calendar
  end

  describe "initiates a new reservation" do
    it "creates a reservation object" do
      reservation = Reservation.new(2, 2017, 9, 10, 2017, 9, 11)
      reservation.must_be_instance_of Reservation
    end

    it "allows you to book a room beginning on the ending date of the previous resveration" do
      reservation = Reservation.new(5, 2017, 9, 15, 2017, 9, 16)
      reservation.must_be_instance_of Reservation
      next_reservation = Reservation.new(5, 2017, 9, 16, 2017, 9, 17)
      next_reservation.must_be_instance_of Reservation

    end

    it "changes the status of a room to booked and does not allow another reservation to overlap" do
      Reservation.new(1, 2017, 9, 18, 2017, 9, 19)
      proc { Reservation.new(1, 2017, 9, 18, 2017, 9, 19)}.must_raise ArgumentError
    end

    it "can return the total cost of a reservation" do
      reservation = Reservation.new(1, 2017, 9, 18, 2017, 9, 19)
      reservation.total_cost.must_be_instance_of Integer
      reservation.total_cost.must_equal 200
      another_reservation = Reservation.new(2, 2017, 9, 18, 2017, 9, 21)
      another_reservation.total_cost.must_be_instance_of Integer
      another_reservation.total_cost.must_equal 600
    end


  end

  def teardown
    Availability.set_calendar([])
  end

end
