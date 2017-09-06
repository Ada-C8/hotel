#reservation_spec.rb
require 'date'

require_relative 'spec_helper.rb'

describe "Reservation Class" do

  describe "Initializing the Reservation Class" do

    before do
      check_in_date = "8/13/17"
      check_out_date = "8/16/17"
      @reservation = Hotel_Chain::Reservation.new(check_in_date, check_out_date)
    end

    it "can be initialized" do
      @reservation.class.must_be_kind_of Class
    end

    it "creates a room object and assigns it to the reservation" do
      @reservation.room_id.must_be_kind_of Integer
    end

    it "a reservation has a check-in date" do
      @reservation.check_in_date.must_be_kind_of Date

    end

    it "can return a check-in date" do
      @reservation.check_in_date.must_equal Date.strptime("8/13/17", "%m/%d/%Y")
      #@reservation.check_in_date.to_date.must_equal 0017-08-13
    end

    it "returns the correct cost for the reservation" do
      @reservation.cost.must_equal 600
    end

  end

  describe "error handling" do
    it "raises an error if an incorrect date format is inputted" do
      check_in_date = "2017/08/13"
      check_out_date = "8/16/17"
      proc {Hotel_Chain::Reservation.new(check_in_date, check_out_date)}.must_raise ArgumentError

    end
  end


end
