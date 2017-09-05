require_relative 'spec_helper'

describe "HotelClass" do
  before do
    @hotel_test = Hotel::HotelClass.new
  end
  describe "Initialize Hotel Class" do
    it "HotelClass.new is an instance of Hotel module" do
      @hotel_test.must_be_instance_of Hotel::HotelClass
    end
  end
end
