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

    it "Returns an ArgumentError if the reservation can't be made" do
      # check_in_date is later than check_out_date
      proc {@admin.reserve(Date.new(2017,10,7), Date.new(2017,10,3), 1)}.must_raise ArgumentError

      # room_num given is already reserved for a portion of date a prior reservation has
      @admin.reserve(Date.new(2017,10,3), Date.new(2017,10,7), 1).must_be_instance_of Hotel::Reservation
      proc {@admin.reserve(Date.new(2017,10,3), Date.new(2017,10,7), 1)}.must_raise ArgumentError

      # Non-Date object passed into parameters
      proc{@admin.reserve("I am not a Date!", 123)}.must_raise ArgumentError

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
      @admin.total_cost(new_reservation).must_be_instance_of Integer
      @admin.total_cost(new_reservation).must_equal 600
    end

    it "Returns nil if a Reservation object isn't passed" do
      proc {@admin.total_cost("I am not a Reservation! >:D")}.must_raise ArgumentError
    end
  end

end
