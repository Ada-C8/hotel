require_relative 'spec_helper'

describe "My_Hotel::Reservation" do
  describe "initialize" do
    it "can be created" do
      start_date = [2017, 12, 20]
      end_date = [2017, 12, 20]
      holiday = My_Hotel::Reservation.new(start_date, end_date)
      holiday.must_be_kind_of My_Hotel::Reservation
      holiday.date_range.must_be_kind_of Array
    end

  end
end
