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

    # it "@reservation_id is an integer" do
    #   @reservation.reservation_id.must_be_kind_of Integer
    # end
    #
    # it "@reservation_array is an array" do
    #   @reservation.reservation_array.must_be_kind_of Array
    # end


  end

  # it "@reservation_id increments by 1" do
  #   @reservation.reservation_id.must_equal 1
  #
  # end

  

  it "total_cost method is an integer" do
    @reservation.total_cost.must_equal 800
  end
end
