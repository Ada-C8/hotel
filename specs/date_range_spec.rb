# Testing for date_range
# Edited 9/5/17
require_relative 'spec_helper'

describe "Date Range" do
  describe "initialize method" do
    it "takes checkin and checkout dates" do
      checkin_date = Date.new(2001,2,3)
      checkout_date = Date.new(2001,2,14)
      date =  Hotel::DateRange.new(checkin_date, checkout_date)
      date.must_be_instance_of Hotel::DateRange
    end
  end
  # describe "valid_date" do
  #   it "checks if the checkin and checkout dates are valid"
  #     checkin_date = "2001,2,3"
  #     checkout_date = "2001,2,14"
  #     date =  Hotel::DateRange.new(checkin_date, checkout_date)
  #     date.valid_date?(checkin_date).mumust_be_kind_of date
  # end


  describe "date include" do
    it "checks if the checkin/checkout dates are included in the date range" do
      checkin_date = Date.new(2001,2,3)

      checkout_date = Date.new(2001,2,14)

      date =  Hotel::DateRange.new(checkin_date, checkout_date)

      input_date = Date.new(2001,2,5)

      date.date_include?(input_date) .must_equal true
    end
  end




    #
    # it "checks if only the checkin date is included in the date range" do
    #
    # end
    #
    # it "checks if only the checkout date is included in the date range" do
    #
    # end
    #
    # it "check if the checkin/checkout date are not included in the date range" do
    #
    # end
  # end

end #end of describe block
