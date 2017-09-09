require_relative 'spec_helper'

describe "Testing Room class" do

  let(:room) { Hotel::Room.new(4) }
  let(:today) { Date.today }
  let(:three_days_later) { Date.today + 3 }

  describe "#initialize" do

    it "Creates a Room object with the given room number" do
      room.must_be_instance_of Hotel::Room
      room.room_num.must_equal 4
    end

    it "Sets a default rate if no rate provided" do
      room.rate.must_equal Hotel::Room::DEFAULT_RATE

      expected_rate = 300
      Hotel::Room.new(4, 300).rate.must_equal expected_rate
    end

    it "Raises an error if room number isn't a valid num" do
      # doesn't test for room num > 20 b/c optional param in Hotel allows for more rooms
      proc { Hotel::Room.new(-1) }.must_raise ArgumentError
      proc { Hotel::Room.new(0) }.must_raise ArgumentError
      proc { Hotel::Room.new("cat") }.must_raise TypeError
      proc { Hotel::Room.new(4.23) }.must_raise TypeError
      proc { Hotel::Room.new(nil) }.must_raise TypeError

    end

    it "Creates an empty array of Reservation objects" do
      room.reservations.must_equal []
    end

    it "Creates an empty array of Block objects" do
      room.blocks.must_equal []
    end

  end

  describe "#reserve" do
    before do
      room.reserve(today, three_days_later)
    end

    it "Adds the reservation to the room's reservations array" do
      room.reservations.length.must_equal 1
      room.reservations[0].must_be_instance_of Hotel::Reservation
    end

    it "Reserves the room for the specified start and end dates" do
      res = room.reservations[0]

      res.check_in.must_equal today
      res.check_out.must_equal three_days_later
    end

    it "Raises an error if the room isn't available" do
      proc { room.reserve(today, three_days_later) }.must_raise ArgumentError
    end

    it "Returns the new reservation if the reservation is created" do
      new_res = Hotel::Reservation.new(three_days_later, three_days_later.next_day, room)

      room.reserve(three_days_later, three_days_later.next_day).must_equal new_res
    end

  end

  describe "#is_booked?" do
    before do
      room.reserve(today, three_days_later)
    end

    it "Returns true if the room is booked for a given date (one param + optional param)" do
      room.is_booked?(today).must_equal true
      room.is_booked?(today.next_day).must_equal true
      room.is_booked?(three_days_later).must_equal false

      room.reserve(three_days_later, three_days_later + 2)
      room.is_booked?(three_days_later).must_equal true
    end

    it "Returns true if room is booked for given date range (two params)" do
      room.is_booked?(today - 2, today).must_equal false
      room.is_booked?(today + 1, three_days_later).must_equal true
    end
  end

  describe "#is_blocked?" do

    let(:rooms) { [2, 4, 5, 9, 20].map { |num| Hotel::Room.new(num) } }
    let(:discount) { 0.8 }

    it "Returns true if a room is in a block for the given date range (no reservation)" do
      Hotel::Block.new(today, three_days_later, discount, rooms)
      blocked_room = rooms[0]
      blocked_room.is_blocked?(today - 1, today + 1).must_equal true

      unblocked_room = Hotel::Room.new(15)
      unblocked_room.is_blocked?(today, three_days_later).must_equal false
    end

    it "Returns true if a room is in a block for the given date range (with reservation)" do
      new_block = Hotel::Block.new(today, three_days_later, discount, rooms)
      reserved_room = rooms[0]
      new_block.reserve(reserved_room)
      reserved_room.is_blocked?(today, three_days_later).must_equal true

      unblocked_room_with_res = Hotel::Room.new(15)
      unblocked_room_with_res.reserve(today, three_days_later)
      unblocked_room_with_res.is_blocked?(today, three_days_later).must_equal false
    end
  end
end
