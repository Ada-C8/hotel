require_relative 'spec_helper'

describe 'Hotel' do
  before do
    @peach_castle = Hotel::Hotel.new

    dates = Hotel::DateRange.new(Date.new(2017, 10, 13), Date.new(2017, 10, 31))
    @honeymoon = Hotel::Reservation.new(dates, 13, 200)

    dates = Hotel::DateRange.new(Date.new(2017, 1, 13), Date.new(2017, 1, 31))
    @birthday = Hotel::Reservation.new(dates, 13, 200)

    @peach_castle.add_reservation(@honeymoon)
    @peach_castle.add_reservation(@birthday)
  end

  describe 'available_rooms' do
    it 'returns a list of all rooms when all are available' do
      dates = Hotel::DateRange.new(Date.new(2018, 10, 13), Date.new(2018, 10, 31))
      @peach_castle.available_rooms(dates).must_equal @peach_castle.rooms
    end

    it 'returns list of rooms available' do
      dates = Hotel::DateRange.new(Date.new(2017, 10, 10), Date.new(2017, 10, 15))
      @peach_castle.available_rooms(dates).wont_include 13
      @peach_castle.available_rooms(dates).length.must_equal 19
    end
  end # end available_rooms

  describe 'add_reservation' do
    it 'adds a reservation' do
      dates = Hotel::DateRange.new(Date.new(2017, 2, 13), Date.new(2017, 2, 28))
      batmitzvah = Hotel::Reservation.new(dates, 13, 200)
      @peach_castle.add_reservation(batmitzvah)

      @peach_castle.reservations.length.must_equal 3
    end

    it 'raises an error if the room is already booked' do
      dates = Hotel::DateRange.new(Date.new(2017, 10, 13), Date.new(2017, 10, 31))
      batmitzvah = Hotel::Reservation.new(dates, 13, 200)

      proc{@peach_castle.add_reservation(batmitzvah)}.must_raise Hotel::Hotel::InvalidRoomError
    end

    it 'will not add an invalid reservation to the array' do
      dates = Hotel::DateRange.new(Date.new(2017, 10, 13), Date.new(2017, 10, 31))
      batmitzvah = Hotel::Reservation.new(dates, 13, 200)

      proc{@peach_castle.add_reservation(batmitzvah)}.must_raise Hotel::Hotel::InvalidRoomError
      @peach_castle.reservations.length.must_equal 2
    end
  end # end add_reservation

  describe 'all_reservations' do
    it 'returns a list of all reservations' do
      @peach_castle.all_reservations.must_equal ["Check In: 2017-10-13
Check Out: 2017-10-31
Room Number: 13
Total Cost: $3600",
"Check In: 2017-01-13
Check Out: 2017-01-31
Room Number: 13
Total Cost: $3600"]
    end # sorry I know this is ugly but tabbing it will make it fail!
  end # end all_reservations

  describe 'list_on_date' do
    it 'returns a list of reservations on a date' do
      @peach_castle.list_on_date(Date.new(2017, 10, 20)).must_equal ["Check In: 2017-10-13
Check Out: 2017-10-31
Room Number: 13
Total Cost: $3600"]
    end

    it 'returns an empty array if there are no reservations on a date' do
      @peach_castle.list_on_date(Date.new(2020, 12, 25)).must_equal []
    end

    it 'returns a list including an added reservation on a date' do
      dates = Hotel::DateRange.new(Date.new(2017, 10, 10), Date.new(2017, 10, 15))
      batmitzvah = Hotel::Reservation.new(dates, 1, 200)
      @peach_castle.add_reservation(batmitzvah)

      @peach_castle.list_on_date(Date.new(2017, 10, 13)).must_equal ["Check In: 2017-10-13
Check Out: 2017-10-31
Room Number: 13
Total Cost: $3600", "Check In: 2017-10-10
Check Out: 2017-10-15
Room Number: 1
Total Cost: $1000"]
    end
  end # end list_on_date

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
end
