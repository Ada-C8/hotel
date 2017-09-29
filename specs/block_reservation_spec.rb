require_relative 'spec_helper'
require 'date'


describe "Reservaton Class" do
  describe "Initialize" do

    it "Should be able to instantiate a reservation" do
      date = Date.today
      new_block_reservation = HotelManagment::BlockReservation.new("marisa", "morris", date + 1, date + 3, 1)
      new_block_reservation.must_be_instance_of HotelManagment::BlockReservation
    end

    it "First name should be an instance of String" do
      date = Date.today
      new_block_reservation = HotelManagment::BlockReservation.new("marisa", "morris", date + 1, date + 3, 1)
      new_block_reservation.first_name.must_be_instance_of String
    end

    it "Last name should be an instance of String" do
      date = Date.today
      new_block_reservation = HotelManagment::BlockReservation.new("marisa", "morris", date + 1, date + 3, 1)
      new_block_reservation.last_name.must_be_instance_of String
    end

    it "check_in_date should be an instance of Date" do
      date = Date.today
      new_block_reservation = HotelManagment::BlockReservation.new("marisa", "morris", date + 1, date + 3, 1)
      new_block_reservation.check_in_date.must_be_instance_of Date
    end

    it "check_out_date should be an instance of Date" do
      date = Date.today
      new_block_reservation = HotelManagment::BlockReservation.new("marisa", "morris", date + 1, date + 3, 1)
      new_block_reservation.check_out_date.must_be_instance_of Date
    end

    it "reservation_number must be instance of integer" do
      date = Date.today
      new_block_reservation = HotelManagment::BlockReservation.new("marisa", "morris", date + 1, date + 3, 1)
      new_block_reservation.room_number.must_be_instance_of Integer
    end

  end


  describe "block_rate Method" do

    it "Must respond to block_rate" do
      date = Date.today
      new_block_reservation = HotelManagment::BlockReservation.new("marisa", "morris", date + 1, date + 3, 1)
      new_block_reservation.must_respond_to :block_rate
    end

    it "should return the total cost based on the number of nights reserved" do
      date = Date.today
      new_block_reservation = HotelManagment::BlockReservation.new("marisa", "morris", date + 1, date + 3, 1)
      new_block_reservation.block_rate.must_equal 200
    end
  end

  # describe "validate" do
  #   it "should raise error if block room amount is greater than 5" do
  #     date = Date.today
  #     new_block_reservation = HotelManagment::BlockReservation.new("marisa", "morris", date + 1, date + 6, 6)
  #
  #     proc {new_block_reservation.validate("marisa", "morris", date + 1, date + 4, 6) }.must_raise ArgumentError
  #   end
  # end
end
