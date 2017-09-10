require_relative '../specs/spec_helper'


describe "reservations" do

  before do
    room_num = 1
    check_in = Date.new(2017,2,3)
    check_out = Date.new(2017, 2,7)
    @reservation = Hotel::Reservation.new(room_num, check_in, check_out, discount_percent: 0.3)
  end
  describe "initialize" do
    it "Returns a Reservation object" do
      @reservation.must_be_instance_of Hotel::Reservation

     puts "This is the cost #{@reservation.total_cost}"
    end




  end


  # it "total_cost method is an integer" do
  #   @reservation.total_cost.must_equal 800.00
  # end
end
