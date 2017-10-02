require_relative 'spec_helper'
# puppy_expo = Hotel::Reservation.new('Finn', Date.new(2017, 10, 13), Date.new(2017, 10, 31), Hotel::Room.find(13))
# kitten_expo = Hotel::Reservation.new('Girlie', Date.new(2018, 1, 17), Date.new(2018, 1, 31), Hotel::Room.find(11))

describe 'Reservation' do
  describe 'initialize' do
    it 'creates a room instance with the dates, room, and rate' do
      dates = Hotel::DateRange.new(Date.new(2017, 10, 13), Date.new(2017, 10, 31))
      honeymoon = Hotel::Reservation.new(dates, 13, 200)

      honeymoon.dates.check_in.must_equal Date.new(2017, 10, 13)
      honeymoon.dates.check_out.must_equal Date.new(2017, 10, 31)
      honeymoon.room.must_equal 13
      honeymoon.rate.must_equal 200
    end

    it 'passes in a DateRange object as the dates argument' do
      dates = Hotel::DateRange.new(Date.new(2017, 10, 13), Date.new(2017, 10, 31))
      honeymoon = Hotel::Reservation.new(dates, 13, 200)

      honeymoon.dates.must_be_kind_of Hotel::DateRange
    end

    it 'will not pass in anything but a DateRange object as the dates argument' do
      dates = Hotel::DateRange.new(Date.new(2017, 10, 13), Date.new(2017, 10, 31))
      honeymoon = Hotel::Reservation.new(dates, 13, 200)

      honeymoon.dates.wont_be_kind_of Date
    end
  end

  describe 'final_cost' do
    it 'calculates the cost of the stay based on number of nights times the rate' do
      dates = Hotel::DateRange.new(Date.new(2017, 10, 13), Date.new(2017, 10, 31))
      honeymoon = Hotel::Reservation.new(dates, 13, 200)

      honeymoon.final_cost.must_equal 3600
    end
  end
  # describe 'initialize' do
  #   it 'initializes with guest name, date range from DateRange, and room number from Room' do
  #     puppy_expo.guest_name.must_equal 'Finn'
  #     puppy_expo.dates.check_in.to_s.must_equal '2017-10-13'
  #     puppy_expo.dates.check_out.to_s.must_equal '2017-10-31'
  #   end # end test
  #
  #   it 'raises an InvalidRoomError if room has already been booked' do
  #     proc{Hotel::Reservation.new('Suge', Date.new(2017, 10, 15), Date.new(2017, 10, 20), Hotel::Room.find(13))}.must_raise Hotel::InvalidRoomError
  #   end # end test
  #
  #   it 'will not add invalid reservation to @@reservations' do
  #     number_of_reservations = Hotel::Reservation.reservations.length
  #     begin
  #       Hotel::Reservation.new('Suge', Date.new(2017, 10, 15), Date.new(2017, 10, 20), Hotel::Room.find(13))
  #     rescue
  #     end
  #
  #     Hotel::Reservation.reservations.length.must_equal number_of_reservations # makes sure number did not change!
  #   end # end test
  # end # end #initialize
  #
  # describe 'self.reservations' do
  #   it 'calls the class variable @@reservations, which holds all instances of Reservation in an array' do
  #     Hotel::Reservation.reservations.must_equal [puppy_expo, kitten_expo]
  #   end # end test
  # end # end #self.reservations
  #
  # describe 'self.print_list' do
  #   it 'returns list of all reservations' do
  #     Hotel::Reservation.print_list.must_equal ["Name: Finn\nCheck In: 2017-10-13\nCheck Out: 2017-10-31\nRoom Number: 13\nTotal Cost: $3600", "Name: Girlie\nCheck In: 2018-01-17\nCheck Out: 2018-01-31\nRoom Number: 11\nTotal Cost: $2800"]
  #   end # end test
  # end # end #self.print_list
  #
  # describe 'self.on_date' do
  #   it 'returns a list of reservations for a specific date' do
  #     Hotel::Reservation.on_date(Date.new(2018, 1, 17)).must_equal [kitten_expo]
  #   end # end test
  # end # end #self.on_date
  #
  # describe 'self.available_rooms' do
  #   it 'excludes reservations outside a given date range' do
  #     given_range = Hotel::DateRange.new(Date.new(2017, 01, 01), Date.new(2017, 12, 31))
  #
  #     Hotel::Reservation.available_rooms(given_range).map do |room|
  #       room.room_number
  #     end.wont_include 13
  #   end # end test
  # end # end #self.available_rooms
end # end of all Reservation tests
