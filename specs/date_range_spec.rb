# Testing for date_range
# Edited 9/5/17
require_relative 'spec_helper'

describe "Date Range" do
  describe "initialize method" do
    it "can be instantiated" do
      checkin = 2001,2,3
      checkout = 2001,2,14
      date =  Hotel::DateRange.new(checkin, checkout)
      date.must_be_instance_of Hotel::DateRange
    end
  end

  # describe "date include" do
  #   it "checks if the checkin/checkout dates are included in the date range" do
  #     checkin = 2001,2,3
  #     checkout = 2001,2,14
  #     date_range =  DateRange.new(checkin, checkout)
  #     date_range.include? ()
  #
  #   end
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
