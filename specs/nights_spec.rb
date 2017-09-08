require_relative '../lib/nights'
require_relative 'spec_helper'

describe "NIGHTS" do
  before do
    @summer_somewhere_nights = Nights.new("January 4, 2018", "January 11, 2018")
  end

  describe "#INITIALIZE" do
    it "initialize a date range" do
      @summer_somewhere_nights.must_be_instance_of Nights
    end

    it "Can accurately report the number of nights in a reservation" do
      @summer_somewhere_nights.num_nights.must_equal 7
    end

    it "can show all nights in the reservation date range" do
      @summer_somewhere_nights.nights_reserved.must_equal ["2018-01-04", "2018-01-05", "2018-01-06", "2018-01-07", "2018-01-08", "2018-01-09", "2018-01-10"]

      @summer_somewhere_nights.nights_reserved.length.must_equal 7
    end
  end
end
