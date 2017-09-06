require_relative 'spec_helper'

describe "DateRange" do
  before do
    @before = Date.new(2017,03,31)
    @after = Date.new(2017,10,14)
  end
  describe "self.range" do

  end

  describe "validate" do
    it "returns input unchanged if input is a Date object" do
      DateRange::validate(@before).must_equal @before
    end

    it "returns a Date object if input is a String" do
      date = DateRange::validate('2017-10-14')
      date.must_be_kind_of Date
      date.month.must_equal 10
    end

    it "raises an exception if input is neither Date or String" do
      proc {
        DateRange::validate(20171014)
      }.must_raise TypeError
    end
  end
end
