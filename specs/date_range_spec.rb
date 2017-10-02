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
    before do
      @check_in = Date.new(2017, 10, 13)
      @check_out = Date.new(2017, 10, 31)
      @honeymoon = Hotel::DateRange.new(@check_in, @check_out)
    end

    it 'returns true if the check in dates are the same' do
      birthday = Hotel::DateRange.new(@check_in, @check_out)
      @honeymoon.overlap?(birthday).must_equal true
    end

    it 'returns true if the reservation starts before the other ends' do
      check_in = Date.new(2017, 10, 10)
      check_out = Date.new(2017, 10, 15)
      birthday = Hotel::DateRange.new(check_in, check_out)

      @honeymoon.overlap?(birthday).must_equal true
    end

    it 'returns true if the reservation ends after the other starts' do
      check_in = Date.new(2017, 10, 30)
      check_out = Date.new(2017, 11, 1)
      birthday = Hotel::DateRange.new(check_in, check_out)

      @honeymoon.overlap?(birthday).must_equal true
    end

    it 'returns true if the new date range is contained in the other date range' do
      check_in = Date.new(2017, 10, 15)
      check_out = Date.new(2017, 10, 16)
      birthday = Hotel::DateRange.new(check_in, check_out)

      @honeymoon.overlap?(birthday).must_equal true
    end

    it 'returns true if the new date range contains the other date range' do
      check_in = Date.new(2017, 10, 1)
      check_out = Date.new(2017, 11, 1)
      birthday = Hotel::DateRange.new(check_in, check_out)

      @honeymoon.overlap?(birthday).must_equal true
    end

    it 'returns false if the reservation ends before the other starts' do
      check_in = Date.new(2017, 10, 1)
      check_out = Date.new(2017, 10, 12)
      birthday = Hotel::DateRange.new(check_in, check_out)

      @honeymoon.overlap?(birthday).must_equal false
    end

    it 'returns false if the reservation begins after the other ends' do
      check_in = Date.new(2017, 11, 1)
      check_out = Date.new(2017, 11, 2)
      birthday = Hotel::DateRange.new(check_in, check_out)

      @honeymoon.overlap?(birthday).must_equal false
    end

    it 'returns false if the reservation begins on the other check out date' do
      check_in = Date.new(2017, 10, 1)
      check_out = Date.new(2017, 10, 13)
      birthday = Hotel::DateRange.new(check_in, check_out)

      @honeymoon.overlap?(birthday).must_equal false
    end

    it 'returns false if the reservation ends on the other check in date' do
      check_in = Date.new(2017, 10, 31)
      check_out = Date.new(2017, 11, 1)
      birthday = Hotel::DateRange.new(check_in, check_out)

      @honeymoon.overlap?(birthday).must_equal false
    end
  end # end overlap?

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
