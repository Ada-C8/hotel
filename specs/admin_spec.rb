require_relative 'spec_helper'
require 'pry'

describe "Admin" do
  before do
    @admin = Hotel::Admin.new()
  end

  describe "initialize" do
    it "Can initialize an object of class Admin" do
      @admin.must_be_instance_of Hotel::Admin
    end
  end

  describe "reserve(check_in, check_out, room_num)" do
    it "Can successfully create a reservation" do
      check_in = Date.new(2017,10,3)
      check_out = Date.new(2017,10,7)
      room_num = 1
      @admin.reserve(check_in, check_out, room_num).must_be_instance_of Hotel::Reservation
      @admin.reservations.length.must_equal 1
      @admin.reservations[0].room.room_number.must_equal 1
    end

    # Wave 2
    it "Can make a reservation starting at the check-out date of another reservation" do
      check_in = Date.new(2017,10,3)
      check_out = Date.new(2017,10,7)
      room_num = 1
      @admin.reserve(check_in, check_out, room_num)
      later_check_in = Date.new(2017,10,7)
      later_check_out = Date.new(2017,10,8)
      @admin.reserve(later_check_in, later_check_out, room_num)
      @admin.reservations_at_date(Date.new(2017,10,7)).length.must_equal 1
    end

    it "Shouldn't create a reservation if there's a block that overlaps in date and room number" do
      date1 = Date.new(2017, 8, 10)
      date2 = Date.new(2017, 8, 15)
      room_numbers = [6, 7, 8]
      @admin.create_block(date1, date2, room_numbers)
      # both check in and check out overlap
      proc{@admin.reserve(Date.new(2017, 8, 11), Date.new(2017, 8, 14), 6)}.must_raise ArgumentError
      # check-in overlaps
      proc{@admin.reserve(Date.new(2017, 8, 12), Date.new(2017, 8, 20), 6)}.must_raise ArgumentError
      # check-out overlaps
      proc{@admin.reserve(Date.new(2017, 8, 9), Date.new(2017, 8, 14), 6)}.must_raise ArgumentError
    end

    it "Returns an error if the reservation can't be made" do
      # check_in_date is later than check_out_date
      proc {@admin.reserve(Date.new(2017,10,7), Date.new(2017,10,3), 1)}.must_raise DateRangeInvalidError

      # room_num given is already reserved for a portion of date a prior reservation has
      @admin.reserve(Date.new(2017,10,3), Date.new(2017,10,7), 1).must_be_instance_of Hotel::Reservation
      proc {@admin.reserve(Date.new(2017,10,3), Date.new(2017,10,7), 1)}.must_raise DateOverlapError
      proc {@admin.reserve(Date.new(2017,10,4), Date.new(2017,10,6), 1)}.must_raise DateOverlapError

      # Non-Date object passed into parameters
      proc{@admin.reserve("I am not a Date!", 123, 13)}.must_raise InvalidObjectPassedError

    end

    it "Adds to the list of reservations the admin has" do
      @admin.reserve(Date.new(2017,10,3), Date.new(2017,10,7), 1)
      @admin.reserve(Date.new(2017,10,3), Date.new(2017,10,7), 2)
      @admin.reserve(Date.new(2017,10,3), Date.new(2017,10,7), 3)
      @admin.reservations.length.must_equal 3
    end
  end

  describe "reservations_at_date" do
    it "Returns an array of Reservations at a given Date" do
      new_reservation = @admin.reserve(Date.new(2017,10,3), Date.new(2017,10,7), 1)
      @admin.reserve(Date.new(2017,10,3), Date.new(2017,10,7), 2)
      @admin.reserve(Date.new(2017,10,3), Date.new(2017,10,7), 3)
      reservations_at_date = @admin.reservations_at_date(Date.new(2017, 10, 3))
      reservations_at_date.must_be_instance_of Array
      reservations_at_date.length.must_equal 3
      reservations_at_date[rand(3)].must_be_instance_of Hotel::Reservation
      reservations_at_date[0].must_equal new_reservation
    end

    it "Returns Reservations where the given Date falls within the range of Reservation(s)" do
      @admin.reserve(Date.new(2017,10,1), Date.new(2017,10,5), 1) #10/01 - 10/05
      @admin.reserve(Date.new(2017,10,3), Date.new(2017,10,7), 2) #10/03 - 10/07
      @admin.reserve(Date.new(2017,10,2), Date.new(2017,10,3), 3) #10/02 - 10/03
      reservations_at_date = @admin.reservations_at_date(Date.new(2017, 10, 4))
      reservations_at_date.length.must_equal 2
    end

    it "Shouldn't include Reservations that end at the given Date" do
      @admin.reserve(Date.new(2017,10,1), Date.new(2017,10,4), 5)
      reservations_at_date = @admin.reservations_at_date(Date.new(2017, 10, 4))
      reservations_at_date.length.must_equal 0
    end

    it "Returns a blank array if there are no Reservations at a given Date" do
      @admin.reservations_at_date(Date.new(2017, 10, 4)).length.must_equal 0
      @admin.reservations_at_date(Date.new(2017, 10, 4)).must_be_instance_of Array
    end
  end

  describe "total_cost" do
    it "Returns the total cost of a room reserved for a certain date range" do
      new_reservation = @admin.reserve(Date.new(2017,10,1), Date.new(2017,10,4), 5)
      new_reservation.total_cost.must_be_instance_of Integer
      new_reservation.total_cost.must_equal 600
    end
  end

  describe "find_room(room_number)" do
    it "Returns the Room object with the specific room" do
      local_room = @admin.find_room(1)
      local_room.must_be_instance_of Hotel::Room
    end
  end

  describe "available_rooms_in_date_range" do
    it "Returns an array of Room objects for a given date range" do
      not_available1 = @admin.reserve(Date.new(2017, 10, 2), Date.new(2017, 10, 10), 1)
      not_available2 = @admin.reserve(Date.new(2017, 10, 5), Date.new(2017, 10, 10), 3)
      not_available_rooms = [not_available1, not_available2]
      date1 = Date.new(2017, 10, 3)
      date2 = Date.new(2017, 10, 9)

      available_rooms = @admin.available_rooms_in_date_range(date1, date2)
      available_rooms.must_be_instance_of Array
      available_rooms[rand(available_rooms.length)].must_be_instance_of Hotel::Room
      available_rooms.each do |room|
        not_available_rooms.include?(room).must_equal false
      end
    end

    it "Returns an error if date objects aren't passed" do
      proc{@admin.available_rooms_in_date_range("I am not a date!", "I'm not one too! haha")}.must_raise InvalidObjectPassedError
    end

    it "Returns an error if dates are passed in descending order" do
      proc{@admin.available_rooms_in_date_range(Date.new(2017, 10, 3), Date.new(2017, 10, 1))}.must_raise DateOverlapError
    end

    it "Can return a room that's been previously reserved as available" do
      @admin.reserve(Date.new(2017, 1,1), Date.new(2017, 1,3), 1)
      available_rooms = @admin.available_rooms_in_date_range(Date.new(2017, 1, 4), Date.new(2017, 1, 6))
      available_rooms.length.must_equal 20 #none are booked for a later date
    end

  end

  describe "create_block(date1, date2, room_numbers)" do
    before do
      date1 = Date.new(2017, 8, 10)
      date2 = Date.new(2017, 8, 15)
      @room_numbers = [6, 7, 8]
      @blocked_reservation_1 = @admin.create_block(date1, date2, @room_numbers)
    end

    it "Can create a block reservation without reserving the rooms in it" do
      @blocked_reservation_1.must_be_instance_of Hotel::BlockReservation
      @blocked_reservation_1.rooms.length.must_equal 3
      @blocked_reservation_1.rooms.each do |room|
        @room_numbers.include?(room.room_number).must_equal true
      end
    end

    it "Can create a block reservation at the check out date of another (block) reservation" do
      @admin.create_block(Date.new(2017, 8, 15), Date.new(2017, 8, 17), [6, 7, 8])
      @admin.block_reservations.length.must_equal 2 # includes the old block reservation and new block reservation
      @admin.block_reservations[1].rooms.each do |room|
        [6, 7, 8].include?(room.room_number).must_equal true
      end
    end

    it "Shouldn't create a block if there's a block that overlaps in date and room number" do
      #within check_in and check_out range and room number overlaps w/ existing block
      date1 = Date.new(2017, 8, 11)
      date2 = Date.new(2017, 8, 14)
      room_numbers2 = [6, 7]
      proc { @admin.create_block(date1, date2, room_numbers2) }.must_raise DateOverlapError
    end

    it "Shouldn't create a block if there's an existing reservation that overlaps in date and room number" do
      @admin.reserve(Date.new(2017, 4, 20), Date.new(2017, 4, 25), 13)
      #check in and check out overlaps
      proc{@admin.create_block(Date.new(2017, 4, 21), Date.new(2017, 4, 24), [13, 14, 15])}.must_raise DateOverlapError
      #check in overlaps
      proc{@admin.create_block(Date.new(2017, 4, 21), Date.new(2017, 4, 26), [13, 14, 15])}.must_raise DateOverlapError
      #check out overlaps
      proc{@admin.create_block(Date.new(2017, 4, 19), Date.new(2017, 4, 24), [13, 14, 15])}.must_raise DateOverlapError
    end

    it "Can create multiple block reservations at the same date range but different rooms" do
      date1 = Date.new(2017, 8, 10)
      date2 = Date.new(2017, 8, 15)
      room_numbers2 = [4, 5]
      @admin.create_block(date1, date2, room_numbers2)
      @admin.block_reservations.length.must_equal 2
    end
  end

  # describe "avaialble_in_block(block_reservation, room_num)" do
  #   it "Returns true if a room in the block reservation is unreserved" do
  #
  #   end
  # end

end
