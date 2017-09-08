require_relative 'spec_helper'

describe "Testing Room class" do
  describe "#initialize" do
    before do
      @room = Hotel::Room.new(4)
    end

    it "Creates a Room object" do
      @room.must_be_instance_of Hotel::Room
    end

    it "Sets a default rate if no rate provided" do
      @room.rate.must_equal Hotel::Room::DEFAULT_RATE
    end

    it "Raises an error if room number isn't a valid num" do
      # doesn't test for room num > 20 b/c optional param in Hotel allows for more rooms
      proc { Hotel::Room.new(-1) }.must_raise ArgumentError
      proc { Hotel::Room.new(0) }.must_raise ArgumentError
    end

    it "Creates an empty array of Reservation objects" do
      @room.reservations.must_equal []
    end

    it "Creates an empty array of Block objects" do
      @room.blocks.must_equal []
    end

    # it "Raises an error if room number isn't between 1 & 20" do
    #   proc { Hotel::Room.new(0) }.must_raise ArgumentError
    #   proc { Hotel::Room.new(-2) }.must_raise ArgumentError
    #   proc { Hotel::Room.new(21) }.must_raise ArgumentError
    # end
    #
      # moving input check to user interface
    # it "Raises an error if room number isn't an integer" do
    #   proc { Hotel::Room.new("cat") }.must_raise ArgumentError
    #   proc { Hotel::Room.new(4.23) }.must_raise ArgumentError
    #   proc { Hotel::Room.new(nil) }.must_raise ArgumentError
    # end

  end

  describe "#reserve" do
    before do
      @room = Hotel::Room.new(3)
      @check_in = Date.new(2018,9,5)
      @check_out = Date.new(2018,9,8)

      @room.reserve(@check_in, @check_out)
    end

    it "Adds the reservation to the room's reservations array" do
      @room.reservations.length.must_equal 1
      @room.reservations[0].must_be_kind_of Hotel::Reservation
    end

    it "Reserves the room for the specified start and end dates" do
      res = @room.reservations[0]

      res.check_in.must_equal @check_in
      res.check_out.must_equal @check_out
    end

    it "Raises an error if the room isn't available" do
      proc { @room.reserve(@check_in, @check_out) }.must_raise ArgumentError
    end

    it "Returns the new reservation if the reservation is created" do
      new_res = Hotel::Reservation.new(@check_out, @check_out.next_day, @room)

      @room.reserve(@check_out, @check_out.next_day).must_equal new_res
    end

  end

  describe "#is_booked?" do
    before do
      @room = Hotel::Room.new(3)
      @check_in = Date.new(2018,9,5)
      @check_out = Date.new(2018,9,8)
      @room.reserve(@check_in, @check_out)
    end

    it "Returns true if the room is booked for a given date" do
      @room.is_booked?(Date.new(2018,9,6)).must_equal true
      @room.is_booked?(Date.new(2018,9,8)).must_equal false

      @room.reserve(Date.new(2018,9,8), Date.new(2018,9,10))
      @room.is_booked?(Date.new(2018,9,8)).must_equal true
    end

    it "Returns true if room is booked for given date range" do
      @room.is_booked?(Date.new(2018,9,6), Date.new(2018,9,8)).must_equal true
    end
  end

  describe "#is_blocked?" do
    let(:rooms) { [2, 4, 5, 9, 20].map { |num| Hotel::Room.new(num) } }
    let(:check_in) { Date.new(2018,9,3) }
    let(:check_out) { Date.new(2018,9,5) }
    # let(:block) { Hotel::Block.new(Date.new(2017,9,3), Date.new(2017,9,5), 0.2, rooms) }

    it "Returns true if a room is in a block for the given date range (no reservation)" do
      Hotel::Block.new(check_in, check_out, 0.2, rooms)
      blocked_room = rooms[0]
      blocked_room.is_blocked?(check_in, check_out).must_equal true

      unblocked_room = Hotel::Room.new(15)
      unblocked_room.is_blocked?(check_in, check_out).must_equal false
    end

    it "Returns true if a room is in a block for the given date range (with reservation)" do
      new_block = Hotel::Block.new(check_in, check_out, 0.2, rooms)
      reserved_room = rooms[0]
      new_block.reserve(reserved_room)
      reserved_room.is_blocked?(check_in, check_out).must_equal true

      unblocked_room_with_res = Hotel::Room.new(15)
      unblocked_room_with_res.reserve(check_in, check_out)
      unblocked_room_with_res.is_blocked?(check_in, check_out).must_equal false
    end
  end
end
