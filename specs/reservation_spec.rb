require_relative "spec_helper"

describe "Reservations class" do
  before do
    @reservation = Hotel::Reservation.new(12345, 67890)
  end

  describe "initialize" do
    it "Creates an instance" do
      @reservation.must_be_kind_of Hotel::Reservation
    end

    it "Can access start_date & end_date" do
      @reservation.start_date.must_equal 12345
      @reservation.end_date.must_equal 67890
    end
  end

end
