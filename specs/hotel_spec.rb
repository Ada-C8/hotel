require_relative 'spec_helper'


describe 'Hotel' do
  before do
    @hotel = Hotel::Hotel.new(20)
  end

  describe '#initialize' do
    it "Can be instantiated" do
      @hotel.must_be_kind_of Hotel::Hotel
    end

    it 'Creates an array of rooms' do
      @hotel.rooms.must_be_kind_of Array
      @hotel.rooms.length.must_equal 20
    end

    it 'Creates array of reservations' do
      @hotel.reservations.must_equal []
    end
  end

  describe '#all_rooms' do
    # As an administrator, I can access the list of all of the rooms in the hotel
    it 'Returns an array of all room numbers' do
      @hotel.all_rooms.must_equal (1..20).to_a
    end
  end

  describe '#room' do
    it 'returns the Room with corresponding number' do
      room = @hotel.room(4)
      room.must_be_kind_of Hotel::Room
      room.number.must_equal 4
    end

    it 'returns nil if room is not found' do
      @hotel.room(10000).must_equal nil
    end
  end

  xdescribe '#make_reservation' do
    it "creates a reservation and adds it to the @reservations array" do
      @hotel.make_reservation('2017-09-05', '2017-09-08')

      @hotel.reservations[0].must_be_kind_of Hotel::Reservation
    end
  end
  # As an administrator, I can reserve a room for a given date range

  # As an administrator, I can access the list of reservations for a specific date

  # As an administrator, I can get the total cost for a given reservation
end
