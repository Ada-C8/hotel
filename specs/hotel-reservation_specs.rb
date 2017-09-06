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
      reservation_list.must_be_instance_of Array
      reservation_list.length.must_equal 2
    end
    it "will return a blank array for no reservations" do
      reservation_list = Hotel::Reservation.list_for_date(@end_date+10)
      reservation_list.must_equal []
    end
  end

  describe "Reservation instantiation" do
    it "can be initialized" do
      room_reservation = Hotel::Reservation.new(@start_date,@end_date,Hotel::Room.new(1))
      room_reservation.must_be_instance_of Hotel::Reservation
    end

    it "throws error with wrong dates" do
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
      room_reservation.total_cost.must_equal (room_reservation.rate*3).round(2)
    end
  end

  describe "Block rooms" do
    it "can make a block of rooms" do
      start_date = Date.new(2017,6,5)
      end_date = Date.new(2017,6,8)
      block1 = Hotel::Reservation.block_rooms(start_date, end_date, 5, 150, "Averi")
      block1.must_be_instance_of Hash
      block1["Averi"].must_be_instance_of Array
    end
    it "throws error when block is over 5 rooms" do
      start_date = Date.new(2017,6,5)
      end_date = Date.new(2017,6,8)
      proc{Hotel::Reservation.block_rooms(start_date, end_date, 10, 150, "Averi")}.must_raise ArgumentError
    end
    it "throws error when block is under 1 room" do
      start_date = Date.new(2017,6,5)
      end_date = Date.new(2017,6,8)
      proc{Hotel::Reservation.block_rooms(start_date, end_date, 0, 150, "Averi")}.must_raise ArgumentError
    end
    it "will reduce number of rooms if not enough available" do
      start_date = Date.new(2010,6,5)
      end_date = Date.new(2010,6,8)
      18.times do |i|
        Hotel::Reservation.new(start_date, end_date, Hotel::Room.new(i+1))
      end
      block1 = Hotel::Reservation.block_rooms(start_date, end_date, 5, 150, "Chris")
      block1["Chris"].length.must_equal (20-18)
    end
    it "general public can't reserve block room" do
      start_date = Date.new(2017,6,5)
      end_date = Date.new(2017,6,8)
      Hotel::Reservation.block_rooms(start_date, end_date, 5, 150, "Dee")
      proc{Hotel::Reservation.new(start_date,end_date,Hotel::Room.new(1))}.must_raise ArgumentError
    end
    it "can check if a block of rooms has availability" do
      start_date = Date.new(2017,6,19)
      end_date = Date.new(2017,6,21)
      block_name = "Dee"
      Hotel::Reservation.block_rooms(start_date, end_date, 5, 150, block_name)
      Hotel::Reservation.block_availability(block_name).must_equal true
    end
    it "returns no availabity when there are no block rooms" do
      Hotel::Reservation.block_availability("Mom").must_equal false

      start_date = Date.new(2017,6,9)
      end_date = Date.new(2017,6,11)
      block_name = "Dan"
      Hotel::Reservation.block_rooms(start_date, end_date, 1, 150, block_name)
      Hotel::Reservation.reserve_block_room(block_name)
      Hotel::Reservation.block_availability(block_name).must_equal false
    end
    it "can reserve a block room" do
      start_date = Date.new(2017,6,9)
      end_date = Date.new(2017,6,11)
      block_name = "Dee"
      Hotel::Reservation.block_rooms(start_date, end_date, 5, 150, block_name)
      before_count = Hotel::Reservation.list_all.length
      Hotel::Reservation.reserve_block_room(block_name)
      Hotel::Reservation.list_all.length.must_equal (before_count+1)
    end
    it "throws error if no rooms available in block" do
      start_date = Date.new(2017,7,29)
      end_date = Date.new(2017,7,31)
      block_name = "Dee"
      Hotel::Reservation.block_rooms(start_date, end_date, 1, 150, block_name)
      Hotel::Reservation.reserve_block_room(block_name)
      proc{Hotel::Reservation.reserve_block_room(block_name)}.must_raise ArgumentError
    end
  end
end
