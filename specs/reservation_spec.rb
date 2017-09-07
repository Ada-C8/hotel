require_relative 'spec_helper'
require 'date'

describe "Reservaton Class" do
  describe "Initialize" do

    it "Should be able to instantiate a reservation" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10),1,1)
      new_reservation.must_be_instance_of HotelManagment::Reservation
    end

    it "First name should be an instance of String" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10),1,1)
      new_reservation.first_name.must_be_instance_of String
    end

    it "Last name should be an instance of String" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10),1,1)
      new_reservation.last_name.must_be_instance_of String
    end

    it "check_in_date should be an instance of Date" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10),1,1)
      new_reservation.check_in_date.must_be_instance_of Date
    end

    it "check_out_date should be an instance of Date" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10),1,1)
      new_reservation.check_out_date.must_be_instance_of Date
    end

    it "reservation_number must be instance of integer" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10),1,1)
      new_reservation.reservation_number.must_be_instance_of Integer
    end


    it "room_number must be instance of integer" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1, 1)
      new_reservation.room_number.must_be_instance_of Integer
    end
  end

  describe "Rate Method" do
    it "Must respond to rate  rate" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1, 1)
      new_reservation.must_respond_to :rate
    end

    it "Rate should be an nstance of an Integer" do
      rate = 200
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1, 1)
      nights = new_reservation.check_out_date - new_reservation.check_in_date
      cost = nights.to_i * rate
      cost.must_equal 1000
    end

    it "Rate should be an nstance of an Integer" do
      rate = 200
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1, 1)
      nights = new_reservation.check_out_date - new_reservation.check_in_date
      cost = nights.to_i * rate
      cost.must_be_instance_of Integer
    end

    it "should return the rate based on the number of nights reserved" do
      rate = 200
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1, 1)
      nights = new_reservation.check_out_date - new_reservation.check_in_date
      cost = nights.to_i * rate
      cost.must_equal 1000
    end
  end
end




# tests

# - can add a check in date
# - can add a check out date
