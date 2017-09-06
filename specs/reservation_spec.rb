require_relative 'spec_helper'

describe "Reservation" do
  before do
    @check_in = Date.new(2017,9,15)
    @check_out = Date.new(2017,9,17)
    @date_range = BookingSystem::DateRange.new(@check_in, @check_out)
    @new_reservation = BookingSystem::Reservation.new(@date_range)
  end

  describe "#initialize" do
    it "ID should be an integer" do
      @new_reservation.id.must_be_kind_of Integer
    end
    it "" do
      
    end
  end

end #end of discribe
