require_relative 'spec_helper'

describe "DateRange Class" do
  before do
    @date_range_test = Hotel::DateRange.new("2017-9-12", "2017-9-15")
  end
  describe "Initialize DateRange Class" do
    it "DateRange.new is an instance of Hotel module" do
      @date_range_test.must_be_instance_of Hotel::DateRange
    end
  end
end
