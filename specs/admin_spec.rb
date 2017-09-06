require_relative 'spec_helper'

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
    it "Returns true if it successfully creates a reservation" do
      check_in = Date.new(2017,10,3)
      check_in = Date.new(2017,10,7)
      room_num = 1
      reserve(check_in, check_out, room_num).must_equal true
    end

    it "Returns false if the reservation can't be made" do
      #check_in_date is later than check_out_date
      reserve(Date.new(2017,10,7), Date.new(2017,10,3), 1).must_equal false

      #room_num given is already reserved for a portion of date a prior reservation has
      reserve(Date.new(2017,10,3), Date.new(2017,10,7), 1)
      reserve(Date.new(2017,10,4), Date.new(2017,10,6), 1).must_equal false

    end

    it "Adds to the list of reservations the admin has" do
      new_reservation = reserve(Date.new(2017,10,3), Date.new(2017,10,7), 1)
      @admin.reservation.include?(new_reservation).must_equal true
      
      reserve(Date.new(2017,11,4), Date.new(2017,11,7), 1)
      reserve(Date.new(2017,12,4), Date.new(2017,12,7), 3)
      @admin.reservation.length.must_equal 3
    end
  end



end
