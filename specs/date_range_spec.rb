require_relative 'spec_helper'

describe 'DateRange' do
  before do
    @puppy_dates = Hotel::DateRange.new("10/13/2017", "10/31/2017")
  end # end before

  xdescribe 'initialize' do
    it 'takes a check in date and a check out date' do
      @puppy_dates.check_in.must_equal "10/13/2017"
      @puppy_dates.check_out.must_equal "10/31/2017"
    end # end test 1

    it 'converts check_in and check_out into dates that can be worked on' do
      @puppy_dates.check_in.class.must_equal Date
    end # end test 2
  end # end #initialize
end # end of all tests
