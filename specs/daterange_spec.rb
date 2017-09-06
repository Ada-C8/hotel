require_relative 'spec_helper'
require 'date'

describe 'DateRange' do
  before do
    date1 = Date.new(2017,9,12)
    date2 = Date.new(2017,9,18)
    @daterange = Hotel::DateRange.new(date1, date2)
  end
  describe 'initialize' do
    it 'creates a DateRange object' do
      @daterange.must_be_instance_of Hotel::DateRange
      @daterange.must_respond_to :date1
      @daterange.must_respond_to :date2
    end
  end

  describe 'include?' do
    it 'returns a boolean' do
      included_date = Date.new(2017,9,13)
      excluded_date = Date.new(2017,10,12)
      @daterange.include?(included_date).must_equal true
      @daterange.include?(excluded_date).must_equal false
    end


  end

  describe 'overlap' do

  end

  describe 'end' do

  end

  describe 'begin' do

  end


end
