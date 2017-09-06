require_relative 'spec_helper'

describe "Testing Hotel class" do
  describe "#initialize" do
    before do
      @hotel = Hotel::Hotel.new
    end

    it "Creates a hotel class with an array of rooms" do
      @hotel.must_be_instance_of Hotel::Hotel

      rooms = @hotel.rooms
      rooms.must_be_instance_of Array

      rooms.each do |room|
        room.must_be_instance_of Hotel::Room
      end
    end

    it "Creates a hotel with NUM_ROOMS num of rooms as the default" do
      @hotel.rooms.length.must_equal Hotel::Hotel::NUM_ROOMS
    end

    it "Creates a hotel with the specified number of rooms" do
      num_rooms = 17
      new_hotel = Hotel::Hotel.new(num_rooms)
      new_hotel.rooms.length.must_equal num_rooms
    end

    it "Raises an error if not passed a valid number for num of rooms" do
      invalid_nums = [-1, 0, "dog", 3.14, nil, ""]

      invalid_nums.each do |item|
        proc { Hotel::Hotel.new(item) }.must_raise ArgumentError
      end
    end

  end

  describe "#reserve" do
    before do
      @hotel = Hotel::Hotel.new
      @room1 = @hotel.rooms[0]
    end

    it "Reserves the given room for the given dates" do
      @room1.reservations.must_equal []

      @hotel.reserve('2017/9/3', '2017/9/5', @room1)
      new_res = Hotel::Reservation.new(Date.parse('2017/9/3'), Date.parse('2017/9/5'), @room1.room_num)
      @room1.reservations[0].must_equal new_res
    end
  end

  describe "#find_reservations_by_date" do
    before do
      @hotel = Hotel::Hotel.new

      # res that doesn't conflict with 9/5/17
      5.times do |num|
        room = @hotel.rooms[0 + num]
        @hotel.reserve(Date.new(2017,9,1), Date.new(2017,9,4), room)
      end

      # res that does conflict with 9/5/17
      5.times do |num|
        room = @hotel.rooms[5 + num]
        @hotel.reserve(Date.new(2017,9,4), Date.new(2017,9,9), room)
      end

      # res with start date conflicting with 9/5/17
      5.times do |num|
        room = @hotel.rooms[10 + num]
        @hotel.reserve(Date.new(2017,9,5), Date.new(2017,9,9), room)
      end

      # res with end date not conflicting with 9/5/17
      5.times do |num|
        room = @hotel.rooms[15 + num]
        @hotel.reserve(Date.new(2017,9,3), Date.new(2017,9,5), room)
      end

      @date_to_check = Date.new(2017,9,5)
      @sept5_res = @hotel.find_reservations_by_date(@date_to_check)
    end

    it "Returns a list of reservations for that date" do
      @sept5_res.must_be_kind_of Array
    end

    it "Doesn't include reservations w/a check-out date matching date" do
      @sept5_res.length.must_equal 10

      room3 = @hotel.rooms[2]
      @hotel.reserve(Date.new(2017,9,4), Date.new(2017,9,5), room3)

      updated_res = @hotel.find_reservations_by_date(@date_to_check)
      updated_res.length.must_equal 10

      @hotel.reserve(Date.new(2017,9,5), Date.new(2017,9,6), room3)
      updated_res = @hotel.find_reservations_by_date(@date_to_check)
      updated_res.length.must_equal 11
    end
  end

end
