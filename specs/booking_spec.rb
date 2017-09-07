require_relative 'spec_helper'
require 'pry'


describe "Hotel" do
  describe "Booking" do

    before do
      @room1 = Hotel::Booking.new(Date.new(2017,9,5), Date.new(2017,9,7), 1, 1)
    end
    # errors that that admin could mess up:

    it "booking will include dates and id number" do
      @room1.must_respond_to :dates
      @room1.must_respond_to :id
    end

    it "will calculate total cost" do
      @room1.define_total_cost.must_equal 400
    end
    # it "will have a room number" do
    #   # binding.pry
    #   @room1.rooms.must_be_kind_of Array
    #   @room1.rooms.must_include 2
    # end
  end
end
