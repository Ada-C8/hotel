require_relative "spec_helper"

describe "Reservations class" do

  describe "initialize" do
    it "Creates an instance" do
      new_reservation = Hotel::Reservation.new
      new_reservation.must_be_kind_of Hotel::Reservation
    end
  end

end
