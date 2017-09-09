# require_relative 'spec_helper'
# #
# describe "My_Hotel::Date_Range" do
#   before do
#     @dec20 = Date.civil(2017, 12, 20)
#     @dec26 = Date.civil(2017,12,26)
#     @holiday_dates = My_Hotel::Date_Range.new(@dec20, @dec26)
#   end
#
#   describe "initialize" do
#     it "can be created" do
#       @holiday_dates.must_be_kind_of My_Hotel::Date_Range
#       @holiday_dates.nights.must_be_kind_of Range
#       @holiday_dates.nights.to_a.length.must_equal 7
#     end
#
#     it "can make a one day date range" do
#       short_holiday = My_Hotel::Date_Range.new(@dec20, @dec20)
#       short_holiday.must_be_kind_of My_Hotel::Date_Range
#       short_holiday.nights.must_be_kind_of Array
#       puts short_holiday.nights.class
#       short_holiday.nights.length.must_equal 1
#     end
#   end
#   #
#   describe "overlap?" do
#     it "must return true of the date overlaps with the reservation range" do
#       dec25 = Date.civil(2017,12,25)
#       @holiday_dates.overlap?(dec25).must_equal true # nominal case true
#       @holiday_dates.overlap?(@dec20).must_equal true # checkin day
#
#     end
#
#     it "must return false if date does not overlap with the reservation range" do
#       dec19 = Date.civil(2017,12,19)
#       dec29 = Date.civil(2017,12,29)
#       bc = Date.civil(-4,3,1)
#       @holiday_dates.overlap?(dec19).must_equal false # nominal case false
#       @holiday_dates.overlap?(dec29).must_equal false # checkout day
#       @holiday_dates.overlap?(bc).must_equal false # a date a long time ago
#     end
#
#   end
# end
