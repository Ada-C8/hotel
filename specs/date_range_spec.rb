require_relative 'spec_helper'

describe 'DateRange' do
  before do
    @puppy_dates = Hotel::DateRange.new(Date.new(2017, 10, 13), Date.new(2017, 10, 31))
  end # end before

  describe 'initialize' do
    it 'takes a check in date and a check out date' do
      @puppy_dates.check_in.to_s.must_equal '2017-10-13'
      @puppy_dates.check_out.to_s.must_equal '2017-10-31'
    end # end test

    it 'passes check_in and check_out in as Date objects' do
      @puppy_dates.check_in.class.must_equal Date
      @puppy_dates.check_out.class.must_equal Date
    end # end test
  end # end #initialize

  describe 'length_of_stay' do
    it 'finds the number of days needed for the reservation based on given dates' do
      @puppy_dates.length_of_stay.must_equal 18
    end # end test

    xit 'checks if a room is available on given dates' do

    end # end test
  end # end #date_range

  describe 'reserve_room' do
    xit 'reserves room if given dates are available' do

    end # end test
  end # end #reserve_room
end # end of all DateRange tests
