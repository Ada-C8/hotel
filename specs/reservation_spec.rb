require_relative 'spec_helper'

describe "Reservation class" do
  before do
    @reservation_test = Hotel::Reservation.new(2, "2017-11-12","2017-11-15")

  end
  describe "Initialize Reservation class" do
    it "Reservation.new is an instance of Hotel module" do
      @reservation_test.must_be_instance_of Hotel::Reservation
    end
    it "Responds to date_range variable" do
      @reservation_test.must_respond_to :date_range
    end
    it "Responds to cost_per_night variable" do
      @reservation_test.must_respond_to :cost_per_night
    end
  end
  describe "Get_total method" do
    it "Calulates total" do
      total = @reservation_test.get_total
      total.must_equal 600
    end
  end

end # end describe Reservation class
