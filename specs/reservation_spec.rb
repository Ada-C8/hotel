require 'pry'
require_relative 'spec_helper'

describe "Reservation class" do
  before do
    @res_test = Hotel::Reservation.new("2001/1/1", "2001/1/5")
  end #before

  # describe "initialize" do
  #   it "can instantiate a reservation class" do
  #     Hotel::Reservation.new.must_be_kind_of Hotel::Reservation
  #   end
  # end

describe "Calling Check_in and Check_out" do
  it "can assign a date object to the check in variable" do
    @res_test.day_in.must_be_kind_of Hotel::DateRange
  end

end





end #Reservation class
