require_relative '../specs/spec_helper'


describe "reservations" do
  describe "initialize" do
    it "Returns a Reservation object" do
      Hotel::Reservation.new.must_be_instance_of Hotel::Reservation
    end


  end
end
