require_relative 'spec_helper'

describe 'Dates' do
  before do
    @checkin = Date.new(2017, 10, 31)
    @checkout = Date.new(2017, 11, 4)
  end

  describe '#self.past_date?(date)' do
    it 'Raises error if a date given is before today' do
      proc {
        Hotels::Dates.past_date?(@checkin - 90)
      }.must_raise ArgumentError
    end
  end # ------------------------- describe #self.past_date? block

  describe '#self.date_check?(checkin, checkout)' do
    it 'Raises error if the checkout date is earlier than the checkin date' do
      proc {
        Hotels::Dates.date_check?(@checkout, @checkin)
      }.must_raise ArgumentError
    end
  end # ------------------------- describe #self.date_check? block

  describe '#self.add_dates(checkin, checkout, array, marker = 0)' do
    it 'Adds Date data to the given Array' do
      array = []
      Hotels::Dates.add_dates(array, @checkin, @checkout)
      array.wont_be_empty
      array[0].must_be_kind_of Date
    end
    it 'Adds the correct Date to the given Array' do
      array = []
      Hotels::Dates.add_dates(array, @checkin)
      assert_equal @checkin, array[0]
    end
    it 'Adds the correct number of dates to a given Array' do
      array = []
      Hotels::Dates.add_dates(array, @checkin, @checkout)
      assert_equal 4, array.length

      array_with_marker = []
      Hotels::Dates.add_dates(array_with_marker, @checkin, @checkout, 1)
      assert_equal 5, array_with_marker.length
    end
  end # ------------------------- describe #self.add_dates block
end
