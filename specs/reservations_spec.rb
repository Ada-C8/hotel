require_relative 'spec_helper'
require 'date'

describe "reservations class" do
  before do
    Availability.create_calendar
  end

  describe "initiates a new reservation" do
    it "creates a reservation object" do
      reservation = Reservation.new(2, 2017, 9, 8, 2017, 9, 9)
      reservation.must_be_instance_of Reservation
    end

    it "changes the status of a room to booked" do
      Reservation.new(1, 2017, 9, 8, 2017, 9, 9)
      proc { Reservation.new(1, 2017, 9, 8, 2017, 9, 9)}.must_raise ArgumentError
    end

  end

  def teardown
    Availability.set_calendar([])
  end

end
