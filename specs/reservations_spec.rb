require_relative 'spec_helper'
require 'date'

describe "reservations class" do
  describe "initiates a new reservation" do
    it "creates a reservation object" do
      reservation = Reservation.new(20, 2017, 9, 6, 2017, 9, 7)
      reservation.must_be_instance_of Reservation
    end

    it "changes the status of a room to booked" do
      Reservation.new(20, 2017, 9, 6, 2017, 9, 9)
      proc { Reservation.new(20, 2017, 9, 6, 2017, 9, 8) }.must_raise ArgumentError
    end



  end


end
