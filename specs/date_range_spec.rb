require_relative 'spec_helper'

describe 'DateRange' do

  before do
    @before = Date.new(2017,10,1)
    @after = Date.new(2017,10,14)
  end

  describe 'self.range_to' do
    it 'raises ArgumentError if start date is after end date' do
      proc {
        DateRange::range_to(@after,@before)
      }.must_raise ArgumentError
    end

    it 'returns an array of Dates' do
      dates = DateRange::range_to(@before, @after)

      dates.must_be_kind_of Array

      dates.each do |date|
        date.must_be_kind_of Date
      end
    end

    it 'includes all dates up to, but not including, the end date' do
      dates = DateRange::range_to(@before, @after)

      dates.first.strftime.must_equal '2017-10-01'
      dates.last.strftime.must_equal '2017-10-13'
    end
  end

  describe 'self.range_with' do
    it 'raises ArgumentError if start date is after end date' do
      proc {
        DateRange::range_with(@after,@before)
      }.must_raise ArgumentError
    end

    it 'returns an array of Dates' do
      dates = DateRange::range_with(@before, @after)

      dates.must_be_kind_of Array

      dates.each do |date|
        date.must_be_kind_of Date
      end
    end

    it 'includes all dates up to AND including the end date' do
      dates = DateRange::range_with(@before, @after)

      dates.first.strftime.must_equal '2017-10-01'
      dates.last.strftime.must_equal '2017-10-14'
    end
  end


  describe 'validate' do
    it 'returns input unchanged if input is a Date object' do
      DateRange::validate(@before).must_equal @before
    end

    it 'returns a Date object if input is a String' do
      date = DateRange::validate('2017-10-14')
      date.must_be_kind_of Date
      date.month.must_equal 10
    end

    it 'raises an exception if input is neither Date or String' do
      proc {
        DateRange::validate(20171014)
      }.must_raise TypeError
    end
  end
end
