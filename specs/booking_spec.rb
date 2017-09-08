require_relative 'spec_helper'

describe "Booking class" do
  before do
    id = 1
    rooms = [Hotel::Room.new(15),Hotel::Room.new(16)]
    date_range = Hotel::DateRange.new(Date.new(2017,9,5),Date.new(2017,9,8))
    block_info = []
    @reservation = Hotel::Booking.new(id, rooms, date_range,block_info)
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
      @reservation.must_respond_to :block_info
    end
    it "total cost must return the appropriate amount for 2 rooms, and be an Integer" do
      @reservation.total_cost.must_equal 1200
    end
    it "total cost must be an integer" do
      @reservation.total_cost.must_be_kind_of Integer
    end
  end
end
