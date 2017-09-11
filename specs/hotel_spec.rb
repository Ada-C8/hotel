require_relative 'spec_helper'

describe "Hotel" do
  before do
    @check_in = Date.new(2017,9,11)
    @check_out = Date.new(2017,9,13)
    @reservation_dates = HotelHedwig::Reservations.new(@check_in, @check_out)
  end


  # Test pseudocode

  describe "#initialize" do
    it "" do
    end
  end

  describe "all_rooms" do
    it "Must be an array of rooms" do
    end
  end

  describe "reserve_room" do
    it "Must allow reservation by date range" do
    end
  end

  describe "date_reservations" do
    it "Must be able to access reservation list by specific date" do
    end
  end

  describe "total_charges" do
    it "Must have a charge of $200 per night" do
      @charges.must_equal
    end
  end
end
