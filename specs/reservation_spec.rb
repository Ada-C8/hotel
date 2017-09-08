require_relative 'spec_helper'

describe "Administration#Reservation" do

  describe "instantiate a reservation" do
    it "has a check_in and check out date" do
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      reservation = Administration::Reservation.new(check_in, check_out)

      reservation.must_respond_to :check_in
      reservation.check_in.must_equal check_in
      reservation.check_in.must_be_kind_of Date
    end

  describe "#total_nights" do
    it "return the total number of nights for a date range" do
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      reservation = Administration::Reservation.new(check_in, check_out)
      reservation.total_nights.must_equal 4
    end

    it "return the total number of nights when the month and year change" do
      check_in = Date.new(2017, 12, 30)
      check_out = Date.new(2018, 1, 4)
      reservation = Administration::Reservation.new(check_in, check_out)
      reservation.total_nights.must_equal 5
    end

    it "return one for a single night" do
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 2)
      reservation = Administration::Reservation.new(check_in, check_out)
      reservation.total_nights.must_equal 1
    end

    # it "raise ArgumentError if there is no overnight stay" do
    #   check_in = Date.new(2017, 9, 1)
    #   check_out = Date.new(2017, 9, 1)
    #   reservation = Administration::Reservation.new(check_in, check_out)
    #
    #   proc {
    #     reservation.total_nights.must_equal 0
    #   }.must_raise ArgumentError
    # end

  end #end of total_nights

  describe "#total_cost" do
    it "return the correct product of any number of nights and the rate" do
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      reservation = Administration::Reservation.new(check_in, check_out)
      reservation.total_cost.must_equal 800
    end
  end #end of total cost


  end #end of reservation wave 1
end #end of module
