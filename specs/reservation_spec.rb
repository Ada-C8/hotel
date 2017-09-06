require_relative 'spec_helper'

describe "Reservation" do

  before do
    @checkin = Date.new(2017,10,31)
    @checkout = Date.new(2017,11,4)
    @reservation = Hotels::Reservation.new(@checkin, @checkout)
  end

  describe "#initialize" do
    it "Can be initialized" do
      @reservation.must_be_instance_of Hotels::Reservation
    end
    it "Has an ID" do
      @reservation.id.must_be_kind_of Integer
    end
    it "Must contain at least one Date" do
      @reservation.dates[0].must_be_instance_of Date
      @reservation.dates.length.must_be :>=, 1
    end
    it "Checks if checkout is later than checkin time" do
      checkin = Date.new(2017,10,31)
      checkout = Date.new(2016,11,4)
      proc{Hotels::Reservation.new(checkin, checkout)}.must_raise ArgumentError
    end
    it "Creates a new Reservation with a single date parameter" do
      reservation = Hotels::Reservation.new(@checkin)
      reservation.must_be_kind_of Hotels::Reservation
    end
  end #------------------------- describe #initialize block

end
