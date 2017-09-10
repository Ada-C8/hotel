require_relative 'spec_helper'

describe 'DateRange' do
  before do
    @before = Date.new(2017, 10, 1)
    @after = Date.new(2017, 10, 14)
  end

  describe 'self.range_to' do
    it 'returns an array of Dates' do
      dates = DateRange.range_to(@before, @after)

      dates.must_be_kind_of Array

      dates.each do |date|
        date.must_be_kind_of Date
      end
    end

    it 'includes all dates up to, but not including, the end date' do
      dates = DateRange.range_to(@before, @after)

      dates.first.strftime.must_equal '2017-10-01'
      dates.last.strftime.must_equal '2017-10-13'
    end

    it 'raises DatesError if start date is after end date' do
      proc {
        DateRange.range_to(@after, @before)
      }.must_raise DatesError
    end

    it 'raises DatesError if dates do not span at least 1 night' do
      proc {
        DateRange.range_to(@before, @before)
      }.must_raise DatesError
    end

    it 'raises ArgumentError if passed invalid dates' do
      proc {
        DateRange.range_to('sea', 'HAWKS')
      }.must_raise ArgumentError
    end
  end

  describe 'self.overlap?' do
    it 'returns true if provided date range overlaps' do
      overlap = DateRange.overlap?('2017-09-06', '2017-09-07', '2017-09-06', '2017-09-07')
      overlap.must_equal true
    end

    it 'returns false if provided date range does not overlap' do
      overlap = DateRange.overlap?('2017-10-14', '2017-10-15', '2017-09-06', '2017-09-07')
      overlap.must_equal false
    end

    it 'returns true for partial overlap' do
      overlap = DateRange.overlap?('2017-09-06', '2017-09-10', '2017-09-8', '2017-09-20')
      overlap.must_equal true
    end

    it 'allows one range to end the day the next starts' do
      overlap = DateRange.overlap?('2017-09-06', '2017-09-10', '2017-09-10', '2017-09-20')
      overlap.must_equal false
    end

    it 'raises DatesError if either start date is after end date' do
      proc {
        DateRange.overlap?(@after, @before, @before, @after)
      }.must_raise DatesError

      proc {
        DateRange.overlap?(@before, @after, @after, @before)
      }.must_raise DatesError
    end

    it 'raises DatesError if either dates do not span at least 1 night' do
      proc {
        DateRange.overlap?(@before, @before, @before, @after)
      }.must_raise DatesError

      proc {
        DateRange.overlap?(@before, @after, @before, @before)
      }.must_raise DatesError
    end

    it 'raises ArgumentError if passed invalid dates' do
      proc {
        DateRange.overlap?(@before, @after, 'before', 'after')
      }.must_raise ArgumentError
    end
  end

  describe 'self.include_all?' do
    it 'returns true if all searched dates fall within container range' do
      include_all = DateRange.include_all?('2017-10-10', '2017-10-14', @before, @after)

      include_all.must_equal true
    end

    it 'returns false if no searched dates fall within container range' do
      include_all = DateRange.include_all?('2017-11-10', '2017-11-14', @before, @after)

      include_all.must_equal false
    end

    it 'returns false for partial overlap' do
      include_all = DateRange.include_all?('2017-10-10', '2017-11-14', @before, @after)

      include_all.must_equal false
    end

    it 'raises DatesError if either start date is after end date' do
      proc {
        DateRange.include_all?(@after, @before, @before, @after)
      }.must_raise DatesError

      proc {
        DateRange.include_all?(@before, @after, @after, @before)
      }.must_raise DatesError
    end

    it 'raises DatesError if either dates do not span at least 1 night' do
      proc {
        DateRange.include_all?(@before, @before, @before, @after)
      }.must_raise DatesError

      proc {
        DateRange.include_all?(@before, @after, @before, @before)
      }.must_raise DatesError
    end

    it 'raises ArgumentError if passed invalid dates' do
      proc {
        DateRange.include_all?(@before, @after, 'before', 'after')
      }.must_raise ArgumentError
    end
  end

  describe 'self.validate' do
    # TODO: edge tests
    it 'returns input unchanged if input is a Date object' do
      DateRange.validate(@before).must_equal @before
    end

    it 'returns a Date object if input is a String' do
      date = DateRange.validate('2017-10-14')
      date.must_be_kind_of Date
      date.month.must_equal 10
    end

    it 'raises an exception if input is neither Date or String' do
      proc {
        DateRange.validate(2017_10_14)
      }.must_raise ArgumentError
    end
  end

  describe 'self.validate_order' do
    it 'returns true if it is two dates in correct order' do
      DateRange.validate_order(@before, @after).must_equal true
    end

    it 'raises DatesError if input is two dates in incorrect order' do
      proc {
        DateRange.validate_order(@after, @before)
      }.must_raise DatesError
    end

    it 'raises DatesError if input dates do not span at least 1 night' do
      proc {
        DateRange.validate_order(@after, @after)
      }.must_raise DatesError
    end

    it 'raises ArgumentError if passed invalid dates' do
      proc {
        DateRange.validate_order('sea', 'HAWKS')
      }.must_raise ArgumentError
    end
  end
end
