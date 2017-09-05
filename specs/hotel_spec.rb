require_relative 'spec_helper'

describe "Hotel" do
  describe "#initialize" do
    it "can be initialized" do
      conrad = Hotels::Hotel.new
      conrad.must_be_instance_of Hotels::Hotel
    end
  end
end
