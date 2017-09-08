require_relative './spec_helper'
require_relative '../lib/reservations'

describe "#RESERVATIONS" do
  before do
    @room = [Room.new(1, 200)]
    @new_reservation = Reservation.new("January 16, 2018", "January 18, 2018", @room)

    @new_reservation1 = Reservation.new("15-05-2018", "22-05-2018", @room)
  end

  describe "single-room reservations" do

    it "An Administrator can initialize an instance of Reservation for a room" do
      @new_reservation.must_be_instance_of Reservation
      @new_reservation.check_in.must_be_instance_of Date
      @new_reservation.check_out.must_be_instance_of Date
      @new_reservation.room_numbers.first.must_equal 1
      @new_reservation.must_respond_to :reservation_id

    end

    it "Raises an Argument error for invalid input" do
      proc {Reservation.new("yesterday", "tomorrow", @room)}.must_raise ArgumentError

      proc {Reservation.new("tomorrow", "today", @room)}.must_raise ArgumentError

      proc {Reservation.new("January 4, 2018", "hey", @room)}.must_raise ArgumentError

      proc{Reservation.new("today", "tomorrow", @room)}.must_raise ArgumentError

      proc{Reservation.new("01-18-2018", "01-18-2018", @room)}.must_raise ArgumentError
    end


    it "Can accurately report the number of nights in a reservation" do
      @new_reservation.num_nights.must_equal 2
    end

    it "can calculate the cost for a reservation" do
      @new_reservation.bill.must_equal 400
      @new_reservation1.bill.must_equal 1400
    end

    it "can show all nights in the reservation date range" do
      @new_reservation.nights.must_equal ["2018-01-16", "2018-01-17"]
      @new_reservation1.nights.length.must_equal 7
    end
  end

  describe "#BLOCKS" do
    it "Can make a reservation containing more than one room" do
      @block_reserve = {check_in: "January 20, 2018", check_out: "January 25, 2018", rooms: [Room.new(25, 200), Room.new(26, 150), Room.new(27, 250)]}

      @my_block = Reservation.new(@block_reserve[:check_in], @block_reserve[:check_out], @block_reserve[:rooms])

      @my_block.must_be_instance_of Reservation
    end

    it "Will accept a discount argument" do
      @block_reserve = {check_in: "January 20, 2018", check_out: "January 25, 2018", rooms: [Room.new(25, 200), Room.new(26, 150), Room.new(27, 250)]}

      @my_block = Reservation.new(@block_reserve[:check_in], @block_reserve[:check_out], @block_reserve[:rooms], 0.8)

      @my_block.bill.must_equal 3000*0.8
    end

    it "Will not create a block with more than 5 rooms." do
      @block2 = {check_in: "January 20, 2018", check_out: "January 25, 2018", rooms: [Room.new(25, 200), Room.new(26, 150), Room.new(27, 250), Room.new(28, 100), Room.new(29, 300), Room.new(30, 140)]}

      proc{Reservation.new(@block2[:check_in], @block2[:check_out], @block2[:rooms])}.must_raise Exception
    end

    it "will not double-book a room in a block" do
      @block_reserve = {check_in: "January 20, 2018", check_out: "January 25, 2018", rooms: [Room.new(25, 200), Room.new(25, 200), Room.new(27, 250)]}

      proc {Reservation.new(@block_reserve[:check_in], @block_reserve[:check_out], @block_reserve[:rooms], 0.8)}.must_raise ArgumentError


    end
  end
end
