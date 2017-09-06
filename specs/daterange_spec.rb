require_relative 'spec_helper'
require 'date'

describe 'DateRange' do
  describe 'initialize' do
    before do
      @date1 = Date.new(2017,9,12)
      @date2 = Date.new(2017,9,18)
      @date3 = Date.new(2017,9,13)
      @daterange = Hotel::DateRange.new(@date1, @date2)
    end
    it 'creates a DateRange object' do
      @daterange.must_be_instance_of Hotel::DateRange
      @daterange.must_respond_to :date1
      @daterange.must_respond_to :date2
    end
  end

  describe 'one_day?' do
    before do
      @date1 = Date.new(2017,9,12)
      @date2 = Date.new(2017,9,12)
      @date3 = Date.new(2017,9,13)
      @daterange = Hotel::DateRange.new(@date1, @date2)
      @daterange2 = Hotel::DateRange.new(@date1, @date3)
    end
    it 'should return true if dates passed are the same' do
      @daterange.one_day?.must_equal true
    end

    it 'should return false if dates passed are not the same' do
      @daterange2.one_day?.must_equal false
    end

  end

  describe 'begin' do
    before do
      @date1 = Date.new(2017,9,12)
      @date2 = Date.new(2017,9,18)
      @daterange = Hotel::DateRange.new(@date1, @date2)
      @daterange2 = Hotel::DateRange.new(@date2, @date1)
    end
    it 'must be a kind of date' do
      @daterange.begin.must_be_kind_of Date
    end
    it 'must identify the correct beginning date' do
      @daterange.begin.must_equal @date1
    end
    it 'must identify the correct beginning date even if passed second' do
      @daterange2.begin.must_equal @date1
    end
  end
  #
  # describe 'end' do

  #   daterange.end.must_be_kind_of Date
  #   @daterange.end(@date1, @date2).must_equal @date2
  # end

  # describe 'include?' do
  #   it 'returns a boolean' do
  #     included_date = Date.new(2017,9,13)
  #     excluded_date = Date.new(2017,10,12)
  #     @daterange.include?(included_date).must_equal true
  #     @daterange.include?(excluded_date).must_equal false
  #   end
  # end

  describe 'overlap' do

  end



end
