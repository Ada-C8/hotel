require_relative 'spec_helper'

describe "Hotel" do

  before do
    @hotel = BookingSystem::Hotel.new
  end

  describe "#initialize" do
    it "should create an instance of Hotel" do
      @hotel.must_be_instance_of BookingSystem::Hotel
      @hotel.rooms.must_be_kind_of Array
      @hotel.rooms.must_respond_to :rooms
      @hotel.all_reservations.must_be_empty
      @hotel.all_reservations.must_respond_to :all_reservations
      # Iterate over rooms to make sure that it is 1 through 20???
    end
  end # Describe

end # Describe
