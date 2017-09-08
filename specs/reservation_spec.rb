require_relative 'spec_helper'
require_relative '../lib/reservation'
require_relative '../lib/daterange'

describe "Reservation" do
  describe "initialize" do
    it "checks initialize" do
	  start_date = Date.new(2017,1,1)
	  end_date = Date.new(2017,1,3)
	  date = DateRange.new(start_date, end_date)
      res = Hotels::Reservation.new(1, date)
	  
	  res.must_respond_to :room_number
	  res.room_number.must_be_kind_of Integer
	  res.room_number.must_equal 1
	  
	  res.must_respond_to :start_date
	  res.start_date.must_equal start_date
	  res.start_date.must_be_kind_of Date
	  
	  res.must_respond_to :end_date
	  res.end_date.must_be_kind_of Date
	  res.end_date.must_equal end_date
	  
	  res.must_respond_to :cost
	  res.cost.must_be_kind_of Integer
	  res.cost.must_equal 400
    end 
	
	it "checks initialize when checkin and checkout are the same day" do
	  start_date = Date.new(2017,1,1)
	  end_date = Date.new(2017,1,1)
	  date = DateRange.new(start_date, end_date)
      res = Hotels::Reservation.new(1, date)
	 
	  res.cost.must_equal 200
    end 
	
  end
end
