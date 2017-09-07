require_relative 'spec_helper'

describe 'Hotel' do
  before do
    @hotel = Hotel::Hotel.new
  end
  describe 'initialize' do
    it 'creates an instance of Hotel' do
      @hotel.must_be_instance_of Hotel::Hotel
    end

    it 'creates a hash of rooms' do
      @hotel.rooms.must_be_kind_of Hash
    end

    it 'creates an array of reservations' do
      @hotel.reservations.must_be_kind_of Array
    end

  end

  describe 'make_reservation' do
    it 'creates a reservation object with two dates and pushes to reservations' do
      @hotel.make_reservation(Date.new(2018,9,12), Date.new(2018,9,15), :room4, 200).must_be_kind_of Array
    end
    it 'creates a reservation object with one date and pushes to reservations' do
      @hotel.make_reservation(Date.new(2018,9,12), :room4, 200).must_be_kind_of Array
    end
    it 'reservations is an array of reservation objects' do
      @hotel.reservations.each do |reservation|
        reservation.must_be_instance_of Hotel::Reservation
      end
    end
end
  describe 'view available' do
    it 'returns a list of rooms that are available for a given date' do
      @date1 = Date.new(2018,9,12)
      @date2 = Date.new(2018,9,15)
      @date3 = Date.new(2018,9,13)
      @date4 = Date.new(2018,9,19)
      @hotel.make_reservation(@date1 , @date2, :room4, 200)
      #@hotel.view_available(Date.new(2018,9,15)).must_respond_to :date1
      @hotel.view_available(@date1).must_be_kind_of Array
      @hotel.view_available(@date1).must_equal [:room1, :room2, :room3, :room5, :room6, :room7, :room8, :room9, :room10,
        :room11, :room12, :room13, :room14, :room15, :room16, :room17, :room18, :room19, :room20]
      @hotel.view_available(@date1, @date2).must_equal [:room1, :room2, :room3, :room5, :room6, :room7, :room8, :room9, :room10,
        :room11, :room12, :room13, :room14, :room15, :room16, :room17, :room18, :room19, :room20]
      @hotel.view_available(@date3, @date4).must_equal [:room1, :room2, :room3, :room5, :room6, :room7, :room8, :room9, :room10,
        :room11, :room12, :room13, :room14, :room15, :room16, :room17, :room18, :room19, :room20]
      @hotel.make_reservation(@date1, @date2, :room5, 200)
      @hotel.view_available(@date1, @date2).must_equal [:room1, :room2, :room3, :room6, :room7, :room8, :room9, :room10,
        :room11, :room12, :room13, :room14, :room15, :room16, :room17, :room18, :room19, :room20]
    end
  end

  describe 'view booked' do
    it 'returns a list of rooms that are booked for a given date' do
      @date1 = Date.new(2018,9,12)
      @date2 = Date.new(2018,9,15)
      @date3 = Date.new(2018,9,13)
      @date4 = Date.new(2018,9,19)
      @hotel.make_reservation(@date1, @date2, :room4, 200)
      @hotel.view_booked(@date1).must_be_kind_of Array
      @hotel.view_booked(@date1).must_equal [:room4]
      @hotel.make_reservation(@date1, @date2, :room5, 200)
      @hotel.view_booked(@date1).must_equal [:room4, :room5]
    end
  end

  describe 'is_available?' do
    it 'returns true if the room is available for the given date range' do
      @date1 = Date.new(2018,9,12)
      @date2 = Date.new(2018,9,15)
      @hotel.is_available?(:room4, @date1, @date2).must_equal true
      @hotel.make_reservation(@date1 , @date2, :room4, 200)
      @hotel.is_available?(:room4, @date1, @date2).must_equal false
    end
  end

  describe 'make reservation for available room' do
    before do
      @date1 = Date.new(2018,9,12)
      @date2 = Date.new(2018,9,15)
    end
    it 'raises BookingError if room is not available' do
      @hotel.make_reservation(@date1, @date2, :room4, 200)
      proc {@hotel.make_reservation(@date1, @date2, :room4, 200)}.must_raise BookingError
    end
    it 'gives a unique id to each reservation' do
      @hotel.make_reservation(@date1, @date2, :room7, 200)
      @hotel.make_reservation(@date1, @date2, :room8, 200)
      @hotel.make_reservation(@date1, @date2, :room9, 200)
      x = 1
      @hotel.reservations.each do |reservation|
        reservation.id.must_equal x
        puts reservation.id
        x+=1
      end
    end
  end


end
