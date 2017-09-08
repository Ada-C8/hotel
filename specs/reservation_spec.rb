require_relative 'spec_helper'

describe 'Reservation' do
  before do
    @puppy_expo = Hotel::Reservation.new('Finn', Date.new(2017, 10, 13), Date.new(2017, 10, 31))
  end # end before

  describe 'initialize' do
    it 'initializes with guest name, date range from DateRange, and room number' do
      @puppy_expo.guest_name.must_equal 'Finn'
      @puppy_expo.dates.check_in.to_s.must_equal '2017-10-13'
      @puppy_expo.dates.check_out.to_s.must_equal '2017-10-31'
    end # end testr
  end # end #initialize

  describe 'reserve_dates' do
    it 'returns the number of days to reserve' do
      @puppy_expo.reserve_dates.must_equal 18
    end # end test

    it 'returns the array of dates needed to be reserved' do

    end # end test
  end # end #reserve_dates

  describe 'finalize_reservation' do
    it 'displays complete reservation info' do
      @puppy_expo.finalize_reservation.must_equal "Name: Finn\nCheck In: 2017-10-13\nCheck Out: 2017-10-31\nRoom Number: 1\nTotal Cost: $3600"
    end # end test
  end # end #final_reservation
end # end of all Reservation tests
