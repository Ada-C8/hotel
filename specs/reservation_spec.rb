require_relative 'spec_helper'

describe "Reservation class" do
  before do
    @reservation_test = Hotel::Reservation.new(1, 2, "2017-9-12","2017-9-15")

  end
  describe "Initialize Reservation class" do
    it "Reservation.new is an instance of Hotel module" do
      @reservation_test.must_be_instance_of Hotel::Reservation
    end
    it "Responds to date_range variable" do
      @reservation_test.must_respond_to :date_range
    end
  end
end # end describe Reservation class
