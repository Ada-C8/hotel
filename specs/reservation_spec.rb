require_relative 'spec_helper'

describe 'Reservation' do

  describe "initialize" do
    it "creates a new instance of Reservation" do
      check_in = Date.new(2018, 03, 11)
      check_out = Date.new(2018, 04, 11)
      name = "guest"
      Reservation.new(name, 1, check_in, check_out).must_be_instance_of Reservation
    end
    
    it "initializes with a new instance of DateRange stored in @dates" do
      check_in = Date.new(2018, 03, 11)
      check_out = Date.new(2018, 04, 11)
      reservation = Reservation.new(name, 1, check_in, check_out)
      reservation.dates.must_be_instance_of DateRange
    end
  end

  describe "total_cost" do
    it "can get the total cost for a given reservation" do
      check_out = Date.new(2018, 03, 14)
      check_in = Date.new(2018, 03, 11)
      name = "guest"
      Reservation.new(name, 1, check_in, check_out).total_cost.must_equal "$600.00"
    end
  end

end
