require_relative 'spec_helper'

describe "Booking class" do
  before do
    id = 1
    rooms = [Hotel::Room.new(15),Hotel::Room.new(16)]
    check_in = Date.new(2017,9,5)
    check_out = Date.new(2017,9,8)
    date_range = Hotel::DateRange.new(check_in,check_out)
    @reservation = Hotel::Booking.new(id, rooms, date_range)
  end
  describe "Initialize" do
    it "can be instantiated" do
      @reservation.must_be_kind_of Hotel::Booking
    end
    it "must respond to all intance variables" do
      @reservation.must_respond_to :id
      @reservation.must_respond_to :total_cost
      @reservation.must_respond_to :rooms
      @reservation.must_respond_to :date_range
      @reservation.must_respond_to :nights
    end
    it "total cost must return the appropriate amount, and be an Integer" do
      @reservation.total_cost.must_be_kind_of Integer
      @reservation.total_cost.must_equal 200
    end
  end
end
