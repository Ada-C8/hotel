require_relative "spec_helper"

describe "reservation class" do
  describe "initialize" do
    it "takes in a starting and ending date" do
      make_date = Hotel::Reservation.new("12-5-2017","12-17-2017")
      make_date.must_be_instance_of Hotel::Reservation
      make_date.check_in.must_be_kind_of Date
      make_date.check_out.must_be_kind_of Date
    end
  end
  describe "date range" do
    it "creates an array of dates" do
      make_date = Hotel::Reservation.new("12-5-2017","12-10-2017")
      make_date.date_range.must_be_kind_of Array
      make_date.date_range.length.must_equal 6
    end
  end

end
