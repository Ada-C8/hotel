require_relative 'spec_helper'

describe "Reservations class" do
  before do
    @reservations = Hotel::Reservations.new
  end
  describe "initializes" do
    it "initializes" do
      @reservations.must_be_kind_of Hotel::Reservations
    end
    it "must respond to all_rooms and all_reservations" do
      @reservations.must_respond_to :all_rooms && :all_reservations
    end
    it "all_rooms must give a list of all of the rooms in the hotel" do
      @reservations.all_rooms.length.must_equal 20
    end
    it "all_reservations must be a kind of array" do
      @reservations.all_reservations.must_be_kind_of Array
    end
  end
end
