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

    it "accurately calculates the length of a stay of 1 night" do
      check_in = Date.new(2017, 11, 14)
      check_out = Date.new(2017, 11, 17)
      reservation = Hotel::Reservation.new(@guest, check_in, check_out)
      reservation.total_nights.must_equal 3
    end

    it "accurately calculates the length of a stay of 1 year" do
      check_in = Date.new(2017, 11, 14)
      check_out = Date.new(2018, 11, 14)
      reservation = Hotel::Reservation.new(@guest, check_in, check_out)
      reservation.total_nights.must_equal 365
    end
  end

  describe "Reader Methods" do
    before do
      check_in = Date.new(2018, 4, 1)
      check_out = Date.new(2018, 4, 22)
      @reservation = Hotel::Reservation.new(@guest, check_in, check_out)
    end

    it "can retrieve the total_nights" do
      @reservation.total_nights.must_equal 21
    end

    it "can retrieve the check_in date" do
      @reservation.check_in.must_equal Date.new(2018, 4, 1)
    end

    it "can retrieve the check_out date" do
      @reservation.check_out.must_equal Date.new(2018, 4, 22)
    end

    # it "can retrieve the room" do
    #
    # end
  end # end of reader Methods

  describe "method include_date?" do
    before do
      @reservation = Hotel::Reservation.new("guest", Date.new(2018, 2, 15), Date.new(2018, 2, 23))
    end

    it "returns true if the reservation includes that date" do
      @reservation = Hotel::Reservation.new("guest", Date.new(2018, 2, 15), Date.new(2018, 2, 23))
      @reservation.include_date?(Date.new(2018, 2, 20)).must_equal true
    end

    it "returns false if the reservation doesn't include that date" do
      @reservation.include_date?(Date.new(2018, 2, 25)).must_equal false
      @reservation.include_date?(Date.new(2018, 2, 2)).must_equal false
    end

    it "returns true if the check_in date is that date" do
      @reservation.include_date?(Date.new(2018, 2, 15)).must_equal true
    end

    it "returns false if the check_out date is that date" do
      @reservation.include_date?(Date.new(2018, 2, 23)).must_equal false
    end

  end #end of method include_date?







end
