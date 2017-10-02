require_relative 'spec_helper'

describe 'DateRange' do
  before do
    @new_date_range = Hotel::DateRange.new("2019-01-01", "2019-01-04")
  end
  describe 'initialize' do
    it 'will initialize' do
      @new_date_range.must_be_instance_of Hotel::DateRange
    end
  end
  describe 'dates method' do
    it 'is an array' do
      @new_date_range.dates.must_be_kind_of Array
    end
    it 'must include the correct number of dates' do
      @new_date_range.dates.length.must_equal 4
    end
  end
end
