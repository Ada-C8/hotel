require_relative 'spec_helper'

describe "Reservation" do
  before do
    @check_in = Date.new(2017,9,15)
    @check_out = Date.new(2017,9,17)
    @date_range = BookingSystem::DateRange.new(@check_in, @check_out)
    @new_reservation = BookingSystem::Reservation.new(@date_range)
    @another_reservation = BookingSystem::Reservation.new(@date_range)
  end

  describe "#initialize" do
    it "ID should be an integer" do
      @new_reservation.id.must_be_kind_of Integer
    end
    it "ID should be 1 for first reservation" do
      @new_reservation.id.must_equal 1
    end
    it "ID should be 2 for second reservation" do
      @another_reservation.id.must_equal 2
    end
    it "Date_range can be called by .date_range" do
      @new_reservation.date_range.must_equal @date_range
    end
    it "Total cost should be an integer" do
      @new_reservation.total_cost.must_be_kind_of Integer
    end
    it "Returns the rigth total cost" do
      @new_reservation.total_cost.must_equal 400
    end

  end

end #end of discribe
