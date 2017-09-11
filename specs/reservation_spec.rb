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

  # describe "total_cost method" do
  #   it "total_cost method is an integer" do
  #     @reservation.total_cost.must_equal 800.00
  #   end
  #
  #   it "total_cost method is an integer" do
  #     @reservation.total_cost.must_equal 800.00
  #   end
  # end

end
