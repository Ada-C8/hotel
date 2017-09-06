require_relative 'spec_helper'

describe "DateRange Class" do
  before do
    @date_range_test = Hotel::DateRange.new("2017-9-12", "2017-9-15")
  end
  describe "Initialize DateRange Class" do
    it "DateRange.new is an instance of Hotel module" do
      @date_range_test.must_be_instance_of Hotel::DateRange
    end
    it "Responds to start_date variable" do
      @date_range_test.must_respond_to :start_date
    end
    it "Responds to end_date variable" do
      @date_range_test.must_respond_to :end_date
    end
    it "Responds to number_of_nights variable" do
      @date_range_test.must_respond_to :number_of_nights
    end
    it "Equals number_of_nights" do
      @date_range_test.number_of_nights.must_equal 3
    end
  end
end
