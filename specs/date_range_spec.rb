# require 'pry'
require_relative 'spec_helper'

describe 'DateRange class' do
  before do
    start_date = Date.new(2017,9,1)
    end_date = Date.new(2017,9,3)
    @range = Hotel::DateRange.new(start_date, end_date)
  end

  describe 'initialize' do
    it 'can be instantiated' do
      @range.must_be_kind_of Hotel::DateRange
    end

    it 'start and end dates are accessible' do
      @range.start_date.mon.must_equal 9
      @range.end_date.day.must_equal 3
    end

    it 'number_of_nights gives right number_of_nights' do
      @range.number_of_nights.must_equal 2
    end

    it 'will throw argument error if dates are backwards/same day' do
      date1 = Date.new(2017,9,1)
      date2 = Date.new(2017,9,3)

      proc {Hotel::DateRange.new(date2, date1)}.must_raise Hotel::InvalidDateRangeError
      proc {Hotel::DateRange.new(date1, date1)}.must_raise Hotel::InvalidDateRangeError
    end
  end

  describe 'nights_arr' do
    it 'creates an Array' do
      @range.nights_arr.must_be_kind_of Array
    end
    it 'is an array full of Dates' do
      @range.nights_arr[0].must_be_kind_of Date
    end
    it 'has the right number of nights' do
      @range.nights_arr.length.must_equal @range.number_of_nights
    end
    it 'actually has the nights you want' do
      @range.nights_arr[0].day.must_equal 1
    end

  end

  xdescribe 'range string' do
    #write this if you get to the CLI
    it 'writes a string with the dates written all prettty' do

    end
  end

end
