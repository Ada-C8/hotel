
require_relative 'spec_helper'

describe "reservations" do
  before do
    checkin = Date.new(2017, 01, 01)
    @number_of_nights = 3
    checkout = checkin + @number_of_nights
    @room_number = 12

    @reservation = Booking::Reservation.new(checkin, checkout, @room_number)
  end

  describe "initialize" do
    it "Should create an instance of a Reservation" do

      @reservation.must_be_kind_of Booking::Reservation
    end


    it "date_range should be an instance of a Date class" do
      # @reservation = Booking::Reservation.new(checkin, checkout, room_number)
      # date_range = Booking::Date.new(date)
      @reservation.date_range.must_be_kind_of Booking::DateRange
    end

    it "should create an instance variable room_number" do
      @reservation.must_respond_to :room_number
      @reservation.room_number.must_equal @room_number
      @reservation.room_number.must_be_kind_of Integer
    end
    it "should create a constant variable COST" do
      # Booking::Reservation.must_respond_to ::COST
      Booking::Reservation::COST.must_equal 200
    end
  end

  describe "total_cost method" do
    it "should return total cost of the stay in the hotel" do
      # reservation = Booking::Reservation.new(date_range, room_number)

      @reservation.total_cost.must_equal @number_of_nights * 200
    end
  end
end
