require_relative 'spec_helper'

describe "My_Hotel::Reservation" do
  describe "initialize" do
    it "can be created" do
      arrive = Date.civil(2017, 12, 20)
      leave = Date.civil(2017, 12, 20)
      holiday = My_Hotel::Reservation.new(arrive, leave)
      holiday.must_be_kind_of My_Hotel::Reservation
      holiday.nights.must_be_kind_of Range
    end




  end
end
