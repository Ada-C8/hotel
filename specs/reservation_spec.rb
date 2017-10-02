require_relative '../specs/spec_helper'


describe "reservations" do

  before do
    room_num = 1
    check_in = Date.new(2017,2,3)
    check_out = Date.new(2017, 2,7)
    @reservation = Hotel::Reservation.new(room_num, check_in, check_out)
  end
  describe "initialize" do
    it "Returns a Reservation object" do
      @reservation.must_be_instance_of Hotel::Reservation
    end
  end

  xdescribe "total_cost method" do
    it "calculating both full and discount price" do
      @reservation.total_cost.must_equal 1000

      Hotel::Reservation.new(2, Date.new(2017,2,2), Date.new(2017,2, 7), 1, discount_percent: 30.0).total_cost.must_equal 700

    end
  end

end
