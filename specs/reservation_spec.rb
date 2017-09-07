require_relative 'spec_helper'

describe 'Reservation' do
  before do
    @puppy_expo = Hotel::Reservation.new('Finn', Date.new(2017, 10, 13), Date.new(2017, 10, 31), 13)
  end # end before

  describe 'initialize' do
    it 'initializes with guest name, date range from DateRange, and room number' do
      @puppy_expo.guest_name.must_equal 'Finn'
      @puppy_expo.dates.check_in.to_s.must_equal "2017-10-13"
      @puppy_expo.dates.check_out.to_s.must_equal "2017-10-31"
      @puppy_expo.room.room_number.must_equal 13
    end # end test

  end # end #initialize

  describe 'reserve_dates' do
    it 'returns the number of days to reserve' do
      @puppy_expo.reserve_dates.must_equal 18
    end # end test
  end # end #reserve_dates
end # end of all Reservation tests
