require_relative 'spec_helper'
#
describe "My_Hotel::Date_Range" do
  describe "initialize" do
    it "can be created" do
      arrive = [2017, 12, 20]
      leave = [2017, 12, 20]
      holiday_dates = My_Hotel::Date_Range.new(arrive,leave)
      holiday_dates.must_be_kind_of My_Hotel::Date_Range

      checkin = holiday_dates.arrive
      checkin.must_be_kind_of Date
      checkout = holiday_dates.leave
      checkout.must_be_kind_of Date
      holiday_dates.nights.must_be_kind_of Range
      (checkin..checkout).to_a.length.must_equal holiday_dates.nights.to_a.length + 1
    end
  end
  #
  #describe "valid_dates" do
  #     #the numbers entered are dates?
  #   end
  #
  describe "overlap?" do
    it "must return true of the date overlaps with the reservation range, false if it does not" do
      arrive = [2017, 12, 20]
      leave = [2017, 12, 29]
      holiday_dates = My_Hotel::Date_Range.new(arrive,leave)
      holiday_dates.must_be_kind_of My_Hotel::Date_Range

      holiday_dates.overlap?([2017,12,25]).must_equal true # nominal case true
      holiday_dates.overlap?([2017,12,19]).must_equal false # nominal case false
      holiday_dates.overlap?([2017,12,20]).must_equal true # checkin day
      holiday_dates.overlap?([2017,12,29]).must_equal false # checkout day
      holiday_dates.overlap?([-4,1,29]).must_equal false # a date a long time ago
    end
  end
  #   describe "make_date_range" do
  #     #the a correct range can be made
  #   end
  #
  #
  #
end
