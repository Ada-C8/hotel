require_relative 'spec_helper'

describe "Hotel" do

  before do
    @conrad = Hotels::Hotel.new
  end

  describe "#initialize" do
    it "Can be initialized" do
      @conrad.must_be_instance_of Hotels::Hotel
    end
    it "Has a collection of Rooms" do
      @conrad.rooms.must_be_kind_of Array
    end
    it "Should have 20 Rooms" do
      @conrad.rooms.length.must_equal 20
    end
    it "Has a collection of Reservations" do
      @conrad.reservations.must_be_kind_of Array
    end
    it "Should initialize with no Reservations" do
      @conrad.reservations.must_be_empty
    end
  end

end
