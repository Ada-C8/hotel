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
    it 'initializes with guest name, date range from DateRange, and room number from Room' do
      @puppy_expo.guest_name.must_equal 'Finn'
      @puppy_expo.dates.check_in.to_s.must_equal '2017-10-13'
      @puppy_expo.dates.check_out.to_s.must_equal '2017-10-31'
    end # end test

    xit 'creates a hash containing all information, including cost' do
      @puppy_expo.list[:guest_name].must_equal 'Finn'
      @puppy_expo.list[:check_in].must_equal '2017-10-13'
      @puppy_expo.list[:check_out].must_equal '2017-10-31'
      @puppy_expo.list[:cost].must_equal 3600
    end
  end # end #initialize

  describe 'self.print_list' do
    it 'displays complete reservation info' do
      @puppy_expo
      Hotel::Reservation.print_list.must_equal "Name: Finn\nCheck In: 2017-10-13\nCheck Out: 2017-10-31\nRoom Number: 1\nTotal Cost: $3600"
    end # end test

    xit 'displays different info for each new reservation w/o overwrite' do
      @puppy_expo.display_reservation.must_equal "Name: Finn\nCheck In: 2017-10-13\nCheck Out: 2017-10-31\nRoom Number: 1\nTotal Cost: $3600"
      @kitten_expo.display_reservation.must_equal "Name: Girlie\nCheck In: 2018-01-17\nCheck Out: 2018-01-31\nRoom Number: 2\nTotal Cost: $2800"
    end
  end # end #self.print_list
end # end of all Reservation tests
