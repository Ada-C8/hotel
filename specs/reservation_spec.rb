require_relative 'spec_helper'

describe 'Reservation' do
  before do
    ############################
    Hotel::Room.initialize_rooms
    ############################
    @puppy_expo = Hotel::Reservation.new('Finn', Date.new(2017, 10, 13), Date.new(2017, 10, 31))
    @kitten_expo = Hotel::Reservation.new('Girlie', Date.new(2018, 1, 17), Date.new(2018, 1, 31))
  end # end before

  describe 'initialize' do
    it 'initializes with guest name, date range from DateRange, and room number' do
      @puppy_expo.guest_name.must_equal 'Finn'
      @puppy_expo.dates.check_in.to_s.must_equal '2017-10-13'
      @puppy_expo.dates.check_out.to_s.must_equal '2017-10-31'
    end # end test
  end # end #initialize
  describe 'finalize_reservation' do
    it 'displays complete reservation info' do
      @puppy_expo.finalize_reservation.must_equal "Name: Finn\nCheck In: 2017-10-13\nCheck Out: 2017-10-31\nRoom Number: 1\nTotal Cost: $3600"
    end # end test

    it 'displays different info for each new reservation w/o overwrite' do
      @puppy_expo.finalize_reservation.must_equal "Name: Finn\nCheck In: 2017-10-13\nCheck Out: 2017-10-31\nRoom Number: 1\nTotal Cost: $3600"
      @kitten_expo.finalize_reservation.must_equal "Name: Girlie\nCheck In: 2018-01-17\nCheck Out: 2018-01-31\nRoom Number: 2\nTotal Cost: $2800"
    end
  end # end #final_reservation
end # end of all Reservation tests
