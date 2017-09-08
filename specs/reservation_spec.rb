require_relative 'spec_helper'

describe "Reservation" do

  before do
    check_in = '2001-02-05'
    check_out = '2001-02-10'
    @reservation = BookingSystem::Reservation.new(1, check_in, check_out)
    # This has @stay_dates, @room_num, @total_cost
  end

  describe "#initialize" do
    it "should create an instance of Reservation" do
      @reservation.must_be_instance_of BookingSystem::Reservation

      @reservation.must_respond_to :check_in
      @reservation.check_in.must_be_instance_of Date

      @reservation.must_respond_to :check_out
      @reservation.check_out.must_be_instance_of Date

      @reservation.must_respond_to :room_num
      @reservation.room_num.must_be_kind_of Integer
      @reservation.room_num.must_equal 1

      @reservation.must_respond_to :total_cost
      @reservation.total_cost.must_be_kind_of Integer
      @reservation.total_cost.must_equal 0
    end
  end # Describe

  describe "#calculate_cost" do
    it "should return an integer" do
      @reservation.calculate_cost.must_be_kind_of Integer
    end

    it "should return the cost of the Reservation, not including the check_out day" do
      @reservation.calculate_cost.must_equal 1000
    end
  end # Describe

end # Describe
