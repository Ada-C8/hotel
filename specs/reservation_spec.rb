require 'date'
require_relative 'spec_helper'


describe "Reservation" do
  before do
    @first_name = "Jane"
    @last_name = "Doe"

    @room_id = 1
    @room_rate = 200.00

    @start_date = Date.new(2017, 9, 1) #Date.new(YYYY, M, D)
    @end_date = Date.new(2017, 9, 5)

    @block_id = "Block1"

    @reservation_test = BookingSystem::Reservation.new(@first_name, @last_name, @room_id, @room_rate, @start_date, @end_date, @block_id)
  end

  describe "#initialize" do
    it "can create an instance of Reservation class" do
      @reservation_test.class.must_equal BookingSystem::Reservation
    end

    it "can take in reserver's identity info as arguments: first_name, last_name" do
      #@reservation_test.must_respond_to(first_name) #? not sure why this gives an error
      @reservation_test.first_name.must_equal("Jane")
      @reservation_test.first_name.must_be_instance_of String

      @reservation_test.last_name.must_equal("Doe")
      @reservation_test.last_name.must_be_instance_of String
    end

    it "can take in room info as arguments: room_id, room_rate" do
      @reservation_test.room_id.must_equal 1
      @reservation_test.room_id.must_be_instance_of Integer

      @reservation_test.room_rate.must_equal 200.00
      @reservation_test.room_rate.must_be_instance_of Float
    end

    it "can take in reservation date objects as arguments: start_date, end_date" do
      @reservation_test.start_date.must_equal(Date.new(2017, 9, 1))
      @reservation_test.start_date.must_be_instance_of Date

      @reservation_test.end_date.must_equal(Date.new(2017, 9, 5))
      @reservation_test.end_date.must_be_instance_of Date
    end

    it "raises an error if start_date and end_date are not date objects" do
      proc { BookingSystem::Reservation.new("Jane", "Doe", 20, 200.00, "2017, 9, 1", 952017) }.must_raise InvalidDateError
    end

    it "#date_range: must return a DateRange object" do
      @reservation_test.must_respond_to :date_range
      @reservation_test.date_range.must_be_instance_of DateRange
    end

    it "raises an error if date range is invalid" do

      start_date = Date.new(2017, 9, 1)
      end_date = Date.new(2015, 9, 5)

      proc {BookingSystem::Reservation.new(@first_name, @last_name, @room_id, @room_rate, start_date, end_date)}.must_raise InvalidDateRangeError
    end
  end

  describe "#get_total_cost" do
    it "can calculate a total" do

      @reservation_test.get_total_cost.must_equal 800.00
      @reservation_test.get_total_cost.must_be_instance_of Float

      @reservation_test.total_cost.must_equal 800.00
      @reservation_test.total_cost.must_be_instance_of Float
    end
  end

end#of_"Reservation"
