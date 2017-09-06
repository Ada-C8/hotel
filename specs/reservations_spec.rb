require_relative 'spec_helper'

describe Hotel::Reservation do
  before do
    @guest = "Ada Lovelace"
  end

  describe "you can create a reservation instance" do
    it "can be created" do
      check_in = Date.new(2017, 11, 14)
      check_out = Date.new(2017, 11, 17)
      reservation = Hotel::Reservation.new(@guest, check_in, check_out)
      reservation.must_be_instance_of Hotel::Reservation
    end

    it "raises an ArgumentError for invalid check_in and check_out arguments" do
      check_in = [2017, 11, 14]
      check_out = [2017, 11, 16]
      proc{Hotel::Reservation.new(@guest, check_in, check_out)}.must_raise ArgumentError
    end

    it "raises an ArgumentError if the check_out date is before or on the same day as the check_in date" do
      check_in = Date.new(2017, 11, 15)
      check_out = Date.new(2017, 11, 15)
      proc {Hotel::Reservation.new(@guest, check_in, check_out)}.must_raise ArgumentError

      check_in = Date.new(2017, 11, 15)
      check_out = Date.new(2017, 11, 14)
      proc {Hotel::Reservation.new(@guest, check_in, check_out)}.must_raise ArgumentError
    end

    it "raises an ArgumentError if the check_in date is before today when initializing" do
      check_in = Date.new(2017, 8, 30)
      check_out = Date.new(2017, 11, 15)
      proc {Hotel::Reservation.new(@guest, check_in, check_out)}.must_raise ArgumentError
    end
  end


end
