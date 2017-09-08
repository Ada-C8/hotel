require_relative 'spec_helper'
require 'date'
# require 'pry'
#FACTOR OUT BEFORE DO LOOPS

describe 'DateRange' do
  describe 'initialize' do
    before do
      @date1 = Date.new(2018,9,12)
      @date2 = Date.new(2018,9,18)
      @date3 = Date.new(2018,9,13)
      @daterange = Hotel::DateRange.new(@date1, @date2)
    end
    it 'creates a DateRange object' do
      @daterange.must_be_instance_of Hotel::DateRange
      @daterange.must_respond_to :beginning
      @daterange.must_respond_to :ending
    end
  end

  describe 'one_day?' do
    before do
      @date1 = Date.new(2018,9,12)
      @date2 = Date.new(2018,9,13)
      @daterange = Hotel::DateRange.new(@date1)
      @daterange2 = Hotel::DateRange.new(@date1, @date2)
    end
    it 'should return true if one date is passed' do
      @daterange.one_day?.must_equal true
    end

    it 'should return false if 2 dates are passed' do
      @daterange2.one_day?.must_equal false
    end

  end

#NEED THIS??
  describe 'beginning' do
    before do
      @date1 = Date.new(2018,9,12)
      @date2 = Date.new(2018,9,18)
      @daterange = Hotel::DateRange.new(@date1, @date2)

    end
    it 'must be a kind of date' do
      @daterange.beginning.must_be_kind_of Date
    end
    it 'must identify the correct beginningning date' do
      @daterange.beginning.must_equal @date1
    end
  end

  describe 'is_valid?' do
    before do
      @date1 = Date.new(2018,9,12)
      @date2 = Date.new(2018,9,20)
      @date3 = Date.new(2017,3,4)
    end
    it 'raises a DateError if someone inputs an end date before a begin date' do
      proc{Hotel::DateRange.new(@date2, @date1)}.must_raise DateError
    end
    it 'raises a DateError if someone inputs a date in the past' do
      proc{Hotel::DateRange.new(@date3)}.must_raise DateError
    end
  end

#NEED THIS??
  describe 'ending' do
    before do
      @date1 = Date.new(2018,9,12)
      @date2 = Date.new(2018,9,18)
      @daterange = Hotel::DateRange.new(@date1, @date2)
    end
    it 'must be kind of date' do
      @daterange.ending.must_be_kind_of Date
    end
    it 'must identify the correct end date if passed second' do
      @daterange.ending.must_equal @date2
    end
  end

  describe 'include?' do
    before do
      @date1 = Date.new(2018,9,12)
      @date2 = Date.new(2018,9,18)
      @date3 = Date.new(2018,9,15)
      @date4 = Date.new(2018,9,20)
      @daterange = Hotel::DateRange.new(@date1, @date2)
    end

    it 'returns a true if the date is included' do
      @daterange.include?(@date3).must_equal true
    end

    it 'returns false if the date is not included' do
      @daterange.include?(@date4).must_equal false
    end

    it "returns true if the date range is just one day" do
      daterange = Hotel::DateRange.new(@date1)
      daterange.include?(@date1).must_equal true
    end
  end

  describe 'number_days' do
    before do
      @date1 = Date.new(2018,9,12)
      @date2 = Date.new(2018,9,18)
      @date3 = Date.new(2018,9,15)
      @date4 = Date.new(2018,9,20)
      @daterange = Hotel::DateRange.new(@date1, @date2)
      @daterange2 = Hotel::DateRange.new(@date1)
    end
    it 'returns an integer' do
      @daterange.number_days.must_be_kind_of Integer
    end
    it "returns the correct number of days for a one day reservation" do
      @daterange2.number_days.must_equal 1
    end

    it 'returns the correct number of days for a multiday reservation' do
      @daterange.number_days.must_equal 7
    end

  end

  describe 'overlap' do
    before do
      @date1 = Date.new(2018,9,12)
      @date2 = Date.new(2018,9,18)
      @date3 = Date.new(2018,9,15)
      @date4 = Date.new(2018,9,20)
      @date5 = Date.new(2018,9,17)
      @date6 = Date.new(2018,9,2)
      @date7 = Date.new(2018,9,11)
      @daterange = Hotel::DateRange.new(@date1, @date2)
      @daterange2 = Hotel::DateRange.new(@date3, @date4)
      @daterange3 = Hotel::DateRange.new(@date3, @date5)
     @daterange6 = Hotel::DateRange.new(@date6, @date7)
    end
    it 'returns true if the date range overlaps with the passed date range by one or all dates' do
      @daterange.overlap?(@daterange2).must_equal true
      @daterange.overlap?(@daterange3).must_equal true
    end
    it 'returns false if the date range does not overlap with the passed date range' do
      @daterange.overlap?(@daterange6).must_equal false
    end

  end
end
