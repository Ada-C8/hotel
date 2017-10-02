require_relative 'spec_helper'

describe 'DateRange' do

  describe 'initialize' do
    it 'passes in two Date objects as check in and check out arguments' do
      check_in = Date.new(2017, 10, 13)
      check_out = Date.new(2017, 10, 31)
      honeymoon = Hotel::DateRange.new(check_in, check_out)

      honeymoon.check_in.must_be_kind_of Date
      honeymoon.check_out.must_be_kind_of Date
    end

    it 'cannot have a negative number of nights' do
      check_out = Date.new(2017, 10, 13)
      check_in = Date.new(2017, 10, 31)

      proc { Hotel::DateRange.new(check_in, check_out) }.must_raise Hotel::DateRange::InvalidDateRange
    end

    it 'cannot book zero nights' do
      check_out = Date.new(2017, 10, 13)
      check_in = Date.new(2017, 10, 13)

      proc { Hotel::DateRange.new(check_in, check_out) }.must_raise Hotel::DateRange::InvalidDateRange
    end
  end # end initialize

  describe 'number_of_nights' do
    it 'returns the number of nights passed in' do
      check_in = Date.new(2017, 10, 13)
      check_out = Date.new(2017, 10, 31)
      honeymoon = Hotel::DateRange.new(check_in, check_out)

      honeymoon.number_of_nights.must_equal 18
    end
  end # end number_of_nights

  describe 'overlap?' do
    it ''
  end

  # before do
  #   @puppy_dates = Hotel::DateRange.new(Date.new(2017, 10, 13), Date.new(2017, 10, 31))
  # end # end before
  #
  # describe 'initialize' do
  #   it 'takes a check in date and a check out date' do
  #     @puppy_dates.check_in.to_s.must_equal '2017-10-13'
  #     @puppy_dates.check_out.to_s.must_equal '2017-10-31'
  #   end # end test
  #
  #   it 'passes check_in and check_out in as Date objects' do
  #     @puppy_dates.check_in.class.must_equal Date
  #     @puppy_dates.check_out.class.must_equal Date
  #   end # end test
  # end # end #initialize
  #
  # describe 'length_of_stay' do
  #   it 'finds the number of days needed for the reservation based on given dates' do
  #     @puppy_dates.length_of_stay.must_equal 18
  #   end # end test
  # end # end #length_of_stay
end # end of all DateRange tests
