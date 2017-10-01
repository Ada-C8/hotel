require_relative 'spec_helper'

describe "reservations class" do
  before do
    Availability.create_calendar
  end

  describe "initiates a new reservation" do
    it "creates a reservation object" do
      reservation = Reservation.new(2, 2017, 11, 10, 2017, 11, 11)
      reservation.must_be_instance_of Reservation
    end

    it "allows you to book a room beginning on the ending date of the previous resveration" do
      reservation = Reservation.new(5, 2017, 10, 15, 2017, 10, 16)
      reservation.must_be_instance_of Reservation
      next_reservation = Reservation.new(5, 2017, 10, 16, 2017, 10, 17)
      next_reservation.must_be_instance_of Reservation
    end

    it "changes the status of a room to booked and does not allow another reservation to overlap" do
      Reservation.new(1, 2018, 9, 28, 2018, 9, 29)
      proc { Reservation.new(1, 2018, 9, 28, 2018, 9, 29)}.must_raise ArgumentError
    end

    it "can return the total cost of a reservation" do
      reservation = Reservation.new(1, 2018, 9, 28, 2018, 9, 29)
      reservation.total_cost.must_be_instance_of Integer
      reservation.total_cost.must_equal 200
      another_reservation = Reservation.new(2, 2018, 9, 28, 2018, 10, 1)
      another_reservation.total_cost.must_be_instance_of Integer
      another_reservation.total_cost.must_equal 600
    end
  end

  describe "reserves from block" do
    it "returns an error if block id does not exist" do
      proc {Reservation.reserve_from_block("Zyxqr")}.must_raise ArgumentError
    end

    it "removes a booked room from the rooms blocked out" do
      Block.new(3, 2017, 12, 8, 2017, 12, 13, "Palmer")
      Availability.all_blocked_rooms(2017, 12, 9).count.must_equal 3
      Reservation.reserve_from_block("Palmer")
      Availability.all_blocked_rooms(2017, 12, 9).count.must_equal 2
    end

    it "changes a room's status from :blocked to :booked" do
      Block.new(3, 2018, 1, 8, 2018, 1, 13, "Jennings")
      Availability.all_blocked_rooms(2018, 1, 8).count.must_equal 3
      Availability.all_reservations(2018, 1, 8).count.must_equal 0
      Reservation.reserve_from_block("Jennings")
      Availability.all_blocked_rooms(2018, 1, 8).count.must_equal 2
      Availability.all_reservations(2018, 1, 8).count.must_equal 1
    end
  end

  def teardown
    Availability.set_calendar([])
  end
end
