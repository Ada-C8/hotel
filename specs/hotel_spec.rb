require_relative 'spec_helper'

describe "Testing Hotel class" do
  let(:hotel) { Hotel::Hotel.new }
  let(:today) { Date.today }
  let(:three_days_later) { Date.today + 3}

  describe "#initialize" do

    it "Creates a hotel class with a hash of rooms" do
      hotel.must_be_instance_of Hotel::Hotel
      hotel.rooms.must_be_kind_of Hash

      hotel.rooms.each do |room_num, room|
        room.must_be_instance_of Hotel::Room
      end
    end

    it "Creates a hotel with NUM_ROOMS num of rooms as the default" do
      hotel.rooms.length.must_equal Hotel::Hotel::NUM_ROOMS
    end

    it "Creates a hotel with the specified number of rooms" do
      num_rooms = 17
      new_hotel = Hotel::Hotel.new(num_rooms)
      new_hotel.rooms.length.must_equal num_rooms
    end

    it "Raises an error if not passed a valid number for num of rooms" do
      proc { Hotel::Hotel.new(-1) }.must_raise ArgumentError
      proc { Hotel::Hotel.new(0) }.must_raise ArgumentError
      proc { Hotel::Hotel.new(nil) }.must_raise TypeError
      proc { Hotel::Hotel.new("cat") }.must_raise TypeError
      proc { Hotel::Hotel.new(3.14) }.must_raise TypeError

    end

    it "Creates rooms with room nums between 1 & specified number of rooms" do
      num_rooms = 25
      big_hotel = Hotel::Hotel.new(num_rooms)
      num_big_hotel_rooms = big_hotel.rooms.length

      big_hotel.rooms.each do |room_num, room|
        room.room_num.must_be :>=, 1
        room.room_num.must_be :<=, num_big_hotel_rooms
      end
    end

  end

  describe "#reserve" do
    before do
      Hotel::Reservation.clear
      @room1 = hotel.rooms[1]
    end

    it "Reserves the given room for the given dates" do
      @room1.reservations.must_equal []

      new_res = hotel.reserve(today, three_days_later, 1)
      @room1.reservations.must_include new_res
    end

    it "Raises error when it tries to reserve a room that's already reserved" do

      hotel.reserve(today, three_days_later, 1)

      proc { hotel.reserve(today + 1, three_days_later, 1) }.must_raise ArgumentError

    end

    it "Raises error when it tries to reserve a room that's in a block" do

      Hotel::Block.new(today, three_days_later, 0.85, [@room1])

      proc { hotel.reserve(today, today + 2, 1) }.must_raise ArgumentError

    end

  end

  describe "#find_reservations_by_date" do
    before do
      Hotel::Reservation.clear
    end

    it "Returns a list of reservations for that date" do
      hotel.find_reservations_by_date(today).must_equal []

      res1 = hotel.reserve(today, three_days_later, 1)
      hotel.find_reservations_by_date(today).must_equal [res1]
      hotel.find_reservations_by_date(three_days_later).must_equal []

      res2 = hotel.reserve(today + 1, three_days_later, 2)
      hotel.find_reservations_by_date(today).must_equal [res1]
      hotel.find_reservations_by_date(today + 1).must_equal [res1, res2]
    end

  end

  describe "#find_avail_rooms" do
    before do
      Hotel::Reservation.clear
    end

    it "Returns hash of rooms available for date range (doesn't count check-out date as unavail)" do
      hotel.find_avail_rooms(today, three_days_later).must_equal hotel.rooms

      hotel.reserve(today, three_days_later, 1)
      hotel.reserve(today, three_days_later + 1, 2)

      hotel.find_avail_rooms(today, three_days_later).wont_include hotel.rooms[2]
      hotel.find_avail_rooms(today, three_days_later - 1).wont_include hotel.rooms[1]
      hotel.find_avail_rooms(today, three_days_later - 1).length.must_equal 18

    end

    it "Raises ArgumentError if start date is later than end date" do
      room1 = hotel.rooms[1]
      proc { hotel.find_avail_rooms(today, three_days_later, room1) }.must_raise ArgumentError

      proc { hotel.find_avail_rooms(hotel, three_days_later, room1) }.must_raise ArgumentError
    end
  end

  describe "#reserve_blocked_room" do
    before do
      Hotel::Reservation.clear
      @block = hotel.block(today, three_days_later, 0.8, [1, 2, 3])
      @room1 = hotel.rooms[1]
    end

    it "Raises ArgumentError if all rooms already booked" do
        @block.reserve(@room1)
        @block.reserve(hotel.rooms[2])
        @block.reserve(hotel.rooms[3])

        proc { hotel.reserve_blocked_room(@block) }.must_raise ArgumentError
    end

    it "Raises ArgumentError if specified room is already booked" do
      @block.reserve(@room1)
      proc { hotel.reserve_blocked_room(@block, 1) }.must_raise ArgumentError
    end

    it "Reserves the specified room in the block" do
      hotel.reserve_blocked_room(@block, 1)

      res = Hotel::Reservation.new(today, three_days_later, @room1)
      @room1.reservations.must_include res
      hotel.find_avail_rooms(today, three_days_later).wont_include(1)
    end

    it "Reserves any available room in block if room num isn't specified" do
      @block.reserve(@room1)

      hotel.reserve_blocked_room(@block)
      hotel.find_avail_rooms(today, three_days_later).wont_include(2 || 3)

      hotel.reserve_blocked_room(@block)
      hotel.find_avail_rooms(today, three_days_later).wont_include(2 && 3)
    end

  end


end
