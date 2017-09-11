require_relative 'spec_helper'
puppy_expo = Hotel::Reservation.new('Finn', Date.new(2017, 10, 13), Date.new(2017, 10, 31))
kitten_expo = Hotel::Reservation.new('Girlie', Date.new(2018, 1, 17), Date.new(2018, 1, 31))

describe 'Reservation' do
  before do
    ############################
    Hotel::Room.initialize_rooms
    ############################
  end # end before

  describe 'initialize' do
    it 'initializes with guest name, date range from DateRange, and room number from Room' do
      puppy_expo.guest_name.must_equal 'Finn'
      puppy_expo.dates.check_in.to_s.must_equal '2017-10-13'
      puppy_expo.dates.check_out.to_s.must_equal '2017-10-31'
    end # end test
  end # end #initialize

  describe 'self.reservations' do
    it 'calls the class variable @@reservations, which holds all instances of Reservation in an array' do
      Hotel::Reservation.reservations.must_equal [puppy_expo, kitten_expo]
    end # end test
  end # end #self.reservations

  describe 'self.print_list' do
    it 'returns list of all reservations' do
      Hotel::Reservation.print_list.must_equal ["Name: Finn\nCheck In: 2017-10-13\nCheck Out: 2017-10-31\nRoom Number: 1\nTotal Cost: $3600", "Name: Girlie\nCheck In: 2018-01-17\nCheck Out: 2018-01-31\nRoom Number: 2\nTotal Cost: $2800"]
    end # end test
  end # end #self.print_list

  describe 'self.on_date' do
    it 'returns a list of reservations for a specific date' do
      Hotel::Reservation.on_date(Date.new(2018, 1, 17)).must_equal [kitten_expo]
    end # end test
  end # end #self.on_date
end # end of all Reservation tests
