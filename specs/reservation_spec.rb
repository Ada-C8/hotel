require_relative 'spec_helper'

describe 'Reservation' do
  before do
    @puppy_expo = Hotel::Reservation.new('Finn', '10/13/2017', '10/31/2017', 13)
  end # end before

  describe 'initialize' do
    it 'initializes with guest name, date range from DateRange, and room number' do
      @puppy_expo.name.must_equal 'Finn'
      @puppy_expo.dates.check_in.must_equal '10/13/2017'
      @puppy_expo.dates.check_out.must_equal '10/31/2017'
    end # end test 1

    it 'room_number = its matching index (minus 1) in ROOMS array' do
      @puppy_expo.room_number.must_equal Hotel::Reservation::ROOMS[13-1]
    end # end test 2
  end # end #initialize
end # end of all tests
