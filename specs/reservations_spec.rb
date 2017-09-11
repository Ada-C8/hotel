require_relative 'spec_helper'

describe "Reservations" do
  before do
    @check_in = Date.new(2017,9,11)
    @check_out = Date.new(2017,9,13)
    @reservation_dates = HotelHedwig::Reservations.new(@check_in, @check_out)
    # @charges = 200 * (@check_out - @check_in)
  end

  it "Must be instance of Reservations" do
    @reservation_dates.must_be_instance_of HotelHedwig::Reservations
  end

  describe "invalid_date" do
    it "must raise argument error if check in date is after check out date" do
      proc { HotelHedwig::Reservations.new(@check_in > @check_out) }.must_raise ArgumentError
    end
  end
end
