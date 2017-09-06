require 'Date'
require_relative 'spec_helper.rb'
# require_relative '../lib/hotel-room'

describe "Hotel::Reservation" do
  before do
    @start_date = Date.new(2017,9,5)
    @end_date = Date.new(2017,9,8)
    @start_date2 = Date.new(2018,9,5)
    @end_date2 = Date.new(2018,9,8)
    @room_1 = Hotel::Room.new(10)
    @room_2 = Hotel::Room.new(20)
  end

  describe "Reservations lists" do
    it "can return a list of reservations for a specific date" do
      Hotel::Reservation.new(@start_date2,@end_date2,@room_1)
      Hotel::Reservation.new(@start_date2,@end_date2,@room_2)
      reservation_list = Hotel::Reservation.list_for_date(@start_date2+1)
      # ap reservation_list
      reservation_list.must_be_instance_of Array
      reservation_list.length.must_equal 2
    end
    it "will return a blank array for no reservations" do
      reservation_list = Hotel::Reservation.list_for_date(@end_date+10)
      # ap reservation_list
      reservation_list.must_equal []
    end
  end

  describe "Reservation instantiation" do
    it "can be initialized" do
      room_reservation = Hotel::Reservation.new(@start_date,@end_date,Hotel::Room.new(1))
      room_reservation.must_be_instance_of Hotel::Reservation
    end

    it "throws error with wrong dates" do
      # bad_date = Date.new(2017,9,1)
      proc{Hotel::Reservation.new(@start_date,@start_date-2,@room_1)}.must_raise ArgumentError
    end

    it "throws error when room is not available" do
      Hotel::Reservation.new(@start_date,@end_date,@room_1)
      proc{Hotel::Reservation.new(@start_date,@end_date,@room_1)}.must_raise ArgumentError
      proc{Hotel::Reservation.new(@start_date+1,@end_date+1,@room_1)}.must_raise ArgumentError
    end

    it "can reserve a room on same day as another reservation ends" do
      room_reserved = Hotel::Reservation.new(@end_date,@end_date+3,@room_1)
      room_reserved.must_be_instance_of Hotel::Reservation
    end
  end

  describe "Reservation methods" do
    it "can return total cost for a given reservation" do
      Hotel::Reservation.new(@start_date+20,@end_date+20,@room_1)
      room_reservation = Hotel::Reservation.list_all[0]
      room_reservation.must_respond_to :total_cost
      room_reservation.total_cost.must_equal (200*3).round(2)
    end
  end
end
