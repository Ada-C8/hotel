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
      @admin.reservations_rooms_hash.length.must_equal 1
    end

    it "Returns an ArgumentError if the reservation can't be made" do
      #check_in_date is later than check_out_date

      #room_num given is already reserved for a portion of date a prior reservation has

    end

    it "Adds to the list of reservations the admin has" do

    end
  end



end
