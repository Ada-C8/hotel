require_relative 'spec_helper'

describe "My_Hotel::Reservation" do
  describe "initialize" do
    it "can be created" do
      first_night = Date.civil(2017, 12, 20)
      last_night = Date.civil(2017, 12, 20)
      holiday = My_Hotel::Reservation.new(first_night, last_night)
      holiday.must_be_kind_of My_Hotel::Reservation
      holiday.nights_booked.must_be_kind_of My_Hotel::Date_Range
    end




  end
end
