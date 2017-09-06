require_relative 'spec_helper'
require 'pry'

describe "Admin" do
  before do
    @admin = Hotel::Admin.new()
  end

  describe "initialize" do
    it "Can initialize an object of class Admin" do
      @admin.must_be_instance_of Hotel::Admin
      @admin.rooms.must_be_instance_of Array
    end
  end

  describe "reserve(check_in, check_out, room_num)" do
    it "Can successfully create a reservation" do
      check_in = Date.new(2017,10,3)
      check_out = Date.new(2017,10,7)
      room_num = 1
      @admin.reserve(check_in, check_out, room_num).must_be_instance_of Hotel::Reservation
    end

    it "Returns an ArgumentError if the reservation can't be made" do
      #check_in_date is later than check_out_date
      proc {@admin.reserve(Date.new(2017,10,7), Date.new(2017,10,3), 1)}.must_raise ArgumentError

      #room_num given is already reserved for a portion of date a prior reservation has
      @admin.reserve(Date.new(2017,10,3), Date.new(2017,10,7), 1)
      proc {@admin.reserve(Date.new(2017,10,4), Date.new(2017,10,6), 1)}.must_raise ArgumentError

    end

    it "Adds to the list of reservations the admin has" do
      new_reservation = @admin.reserve(Date.new(2017,10,3), Date.new(2017,10,7), 1)
      @admin.reservations.include?(new_reservation).must_equal true

      @admin.reserve(Date.new(2017,11,4), Date.new(2017,11,7), 1)
      @admin.reserve(Date.new(2017,12,4), Date.new(2017,12,7), 3)
      @admin.reservations.length.must_equal 3
    end
  end



end
