require_relative "spec_helper"

describe "Reservations class" do
  before do
    @reservation = Hotel::Reservation.new(20, 25)
  end

  describe "initialize" do
    it "Creates an instance" do
      @reservation.must_be_kind_of Hotel::Reservation
    end

    it "Can access start_date & end_date" do
      @reservation.start_date.must_equal 20
      @reservation.end_date.must_equal 25
    end

    it "Creates an array of dates occupied" do
      @reservation.dates.must_be_instance_of Array
      @reservation.dates.length.must_equal 6
    end
  end

end
