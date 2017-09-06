require_relative 'spec_helper'

describe "Reservation" do

  before do
    rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    check_in = '2001-02-03'
    check_out = '2001-02-04'
    @reservation = BookingSystem::Reservation.new(rooms, check_in, check_out)
  end

  describe "#initialize" do
    it "should create an instance of Reservation" do
      @reservation.must_be_instance_of BookingSystem::Reservation

      @reservation.must_respond_to :stay_dates
      @reservation.stay_dates.must_be_kind_of Array

      @reservation.must_respond_to :room_num
      @reservation.room_num.must_be_kind_of Integer

      @reservation.must_respond_to :total_cost
      @reservation.total_cost.must_be_kind_of Integer
      # @reservation.new_date.must_be_instance_of BookingSystem::DateRange()
    end
  end # Describe

  describe "#total_cost" do
    it "should return an integer" do
      @reservation.total_cost.must_be_kind_of Integer
    end
  end # Describe
end # Describe
