require 'Date'
require_relative 'spec_helper.rb'

describe "Hotel::Reservation" do
  describe "Reservations lists" do
    it "can return a list of reservations for a specific date" do
      reservation_list = Hotel::Reservation.list_for_date(@start_date)
      reservation_list.must_be_instance_of Array
      reservation_list.length.must_equal 2
    end
    # it "will return a blank array for no reservations" do
    #   reservation_list = Hotel::Reservation.list_for_date(@end_date+1)
    #   reservation_list.must_equal []
    # end
  end

  before do
    @start_date = Date.new(2017,9,5)
    @end_date = Date.new(2017,9,8)

    @room_reservation = Hotel::Reservation.new(@start_date,@end_date,1)
    @room_reservation2 = Hotel::Reservation.new(@start_date,@end_date,2)
  end

  describe "Reservation instantiation" do
    it "can be initialized" do
      @room_reservation.must_be_instance_of Hotel::Reservation
    end

    it "throws error with wrong dates" do
      bad_date = Date.new(2017,9,1)
      proc{Hotel::Reservation.new(@start_date,bad_date,1)}.must_raise ArgumentError
    end
  end

  describe "Reservation methods" do
    it "can return total cost for a given reservation" do
      @room_reservation.must_respond_to :total_cost
      @room_reservation.total_cost.must_equal (200*3).round(2)
    end
  end
end
