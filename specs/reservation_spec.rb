require_relative 'spec_helper'

describe "Reservation" do
  before do
    @check_in = Date.new(2017,9,15)
    @check_out = Date.new(2017,9,17)
    @room = 5
    @cost = 200
    @date_range = BookingSystem::DateRange.new(@check_in, @check_out)
    @new_reservation = BookingSystem::Reservation.new(@date_range, @room, @cost)
  end

  describe "#initialize" do
    it "ID should be an integer" do
      @new_reservation.id.must_be_kind_of Integer
    end
    it "Date_range can be called by .date_range" do
      @new_reservation.date_range.must_equal @date_range
    end
    it "Total cost should be an integer" do
      # @new_reservation.total_cost.must_be_kind_of Integer
      @new_reservation.total_cost.must_be_kind_of Float
    end
    it "Returns the rigth total cost" do
      # @new_reservation.total_cost.must_equal 400
      @new_reservation.total_cost.must_equal 400
    end
    end

end #end of discribe
