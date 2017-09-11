require_relative 'spec_helper'
require_relative '../lib/daterange'

describe "DateRange" do
  describe "initialize" do
    it "checks initialize" do
      start_date = Date.new(2017,1,1)
	  end_date = Date.new(2017,1,3)
	  date = DateRange.new(start_date, end_date)
	  
	  date.must_respond_to :start_date
	  date.start_date.must_equal start_date
	  date.start_date.must_be_kind_of Date
	  
	  date.must_respond_to :end_date
	  date.end_date.must_be_kind_of Date
	  date.end_date.must_equal end_date
    end 
	
	it "checks initialize when start date is after end date" do 
	  start_date = Date.new(2017,1,1)
	  end_date = Date.new(2017,1,3)
	  proc {DateRange.new(end_date, start_date)}.must_raise Exception
	end
  end
end
