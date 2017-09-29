require_relative 'spec_helper'
require 'date'

describe "Reservaton Class" do
  describe "Initialize" do

    it "Should be able to instantiate a reservation" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10),1)
      new_reservation.must_be_instance_of HotelManagment::Reservation
    end

    it "First name should be an instance of String" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10),1)
      new_reservation.first_name.must_be_instance_of String
    end

    it "Last name should be an instance of String" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10),1)
      new_reservation.last_name.must_be_instance_of String
    end

    it "check_in_date should be an instance of Date" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10),1)
      new_reservation.check_in_date.must_be_instance_of Date
    end

    it "check_out_date should be an instance of Date" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10),1)
      new_reservation.check_out_date.must_be_instance_of Date
    end


    it "room_number must be instance of integer" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1)
      new_reservation.room_number.must_be_instance_of Integer
    end
  end


  describe "Rate Method" do

    it "Must respond to rate" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1)
      new_reservation.must_respond_to :rate
    end


    it "should return the total cost based on the number of nights reserved" do

      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1)
      new_reservation.rate.must_equal 1000
    end

  end

  describe "validate_dates" do

    it "Raises ArgumentError if dates are Invalid" do
      date = Date.today
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", date + 5, date +1, 1)

      proc { new_reservation.validate_dates("marisa", "morris", date + 5, date +1, 1) }.must_raise ArgumentError
    end
  end

end
