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

  describe 'find_available_rooms' do
    # As an administrator, I can view a list of rooms that are not reserved for a given date range
    it 'returns an array of rooms' do
      rooms = @hotel.find_available_rooms('2017-09-05', '2017-09-09')
      rooms.must_be_kind_of Array
    end

    it 'returns only available rooms' do
      @hotel.make_reservation('2017-10-14', '2017-10-18')
      @hotel.make_reservation('2017-10-14', '2017-10-18')
      @hotel.make_reservation('2018-10-14', '2018-10-18')
      rooms = @hotel.find_available_rooms('2017-10-14', '2017-10-18')

      rooms.length.must_equal 18
    end
  end

  describe '#make_reservation' do
    # As an administrator, I can reserve a room for a given date range
    # As an administrator, I can reserve an available room for a given date range
    it "creates a reservation and adds it to the @reservations array" do
      @hotel.make_reservation('2017-09-05', '2017-09-08')
      reservation = @hotel.reservations[0]
      reservation.must_be_kind_of Hotel::Reservation
      reservation.checkout.strftime.must_equal '2017-09-08'
    end

    it 'will reserve the first available room' do
      @hotel.make_reservation('2017-09-05', '2017-09-08')
      @hotel.make_reservation('2017-09-05', '2017-09-08')
      reservation1 = @hotel.reservations[0]
      reservation2 = @hotel.reservations[1]

      reservation1.room.wont_equal reservation2.room
    end

    it 'will book a room again after a reservation ends' do
      @hotel.make_reservation('2017-09-05', '2017-09-08')
      @hotel.make_reservation('2018-09-05', '2018-09-08')
      reservation1 = @hotel.reservations[0]
      reservation2 = @hotel.reservations[1]

      reservation1.room.must_equal reservation2.room
    end

    it 'can book two consecutive reservations to the same room' do
      # A reservation is allowed start on the same day that another reservation for the same room ends
      @hotel.make_reservation('2017-09-05', '2017-09-08')
      @hotel.make_reservation('2017-09-08', '2017-09-11')
      reservation1 = @hotel.reservations[0]
      reservation2 = @hotel.reservations[1]

      reservation1.room.must_equal reservation2.room
    end

    it 'raises NoRoomError if no rooms are available' do
      # Your code should raise an exception when asked to reserve a room that is not available
      proc {
        21.times { @hotel.make_reservation('2017-09-05', '2017-09-08') }
    }.must_raise NoRoomError
    end
  end

  describe '#view_reservations' do
    # As an administrator, I can access the list of reservations for a specific date
    it 'returns an array of Reservations' do
      @hotel.make_reservation('2017-10-14','2017-10-18')
      reservations = @hotel.view_reservations('2017-10-14')

      reservations.must_be_kind_of Array
      reservations.length.must_equal 1
      reservations.each do |reservation|
        reservation.must_be_kind_of Hotel::Reservation
      end
    end
  end
end
