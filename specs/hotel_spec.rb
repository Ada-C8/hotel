require_relative 'spec_helper'

describe "Hotel" do

  before do
    @hotel = BookingSystem::Hotel.new
  end

  describe "#initialize" do
    it "should be an instance of Hotel" do
      @hotel.must_be_instance_of BookingSystem::Hotel
      @hotel.rooms.must_be_kind_of Array
      @hotel.all_reservations.must_be_empty
      # Iterate over rooms to make sure that it is 1 through 20
    end
  end # Describe

end # Describe
