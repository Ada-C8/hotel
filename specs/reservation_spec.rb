#require 'pry'
require_relative 'spec_helper'

describe "Reservation class" do
  before do
    @res_test = Hotel::Reservation.new(1111, 1, "2001/1/1", "2001/1/5")
  end #before

  describe "initialize" do
    before do
      @init_test = Hotel::Reservation.new(1111, 1, "2001/1/1", "2001/1/5")
    end #before

    it "can create an instance of the reservation class" do
      @init_test.must_be_kind_of Hotel::Reservation
    end #must_be_kind_of

    it "can access id, room, check_in and check_out attributes" do
      @init_test.id.must_equal 1111
      @init_test.room.must_equal 1
      @init_test.check_in.must_be_kind_of Date
      @init_test.check_out.must_be_kind_of Date
    end #attributes
  end #Initialize

  describe "Calling Check_in and Check_out" do
    it "can assign a date object to the check in variable" do
      @res_test.check_in.must_be_kind_of Date
    end
  end
end #Reservation class
