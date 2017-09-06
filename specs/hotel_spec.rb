require_relative 'spec_helper'

describe Hotels::Hotel do
  before do
    @conrad = Hotels::Hotel.new
    @checkin = Date.new(2017, 10, 31)
    @checkout = Date.new(2017, 11, 4)
  end # ------------------------- before block

  describe '#initialize' do
    it 'Can be initialized' do
      @conrad.must_be_instance_of Hotels::Hotel
    end
    it 'Has a collection of Rooms' do
      @conrad.rooms.must_be_kind_of Array
    end
    it 'Should have 20 Rooms' do
      assert_equal 20, @conrad.rooms.length
    end
    it 'Has a collection of Reservations' do
      @conrad.reservations.must_be_kind_of Array
    end
    it 'Should initialize with no Reservations' do
      @conrad.reservations.must_be_empty
    end
  end # ------------------------- describe #initialize block

  describe '#list_rooms' do
    it 'Returns a list of rooms' do
      @conrad.list_rooms.must_be_kind_of Array
    end
    it 'Must contain 20 data entries' do
      assert_equal 20, @conrad.list_rooms.length
    end
    it 'Should contain only room numbers (Integers)' do
      @conrad.list_rooms[5].must_be_kind_of Integer
    end
  end # ------------------------- describe #list_rooms block

  describe '#reserve_room' do
    it 'Returns a new Reservation' do
      reservation = @conrad.reserve_room(@checkin, @checkout)
      reservation.must_be_instance_of Hotels::Reservation
    end
    it 'Adds a new Reservation to the @reservations Array' do
      @conrad.reserve_room(@checkin, @checkout)
      assert_equal 1, @conrad.reservations.length
    end
    it 'Reserves the room for the correct number of nights' do
      nights = @conrad.reserve_room(@checkin, @checkout).dates.length
      assert_equal 4, nights
    end
  end # ------------------------- describe #reserve_room block

  describe '#check_reserved' do
    it 'Returns an Array' do
      @conrad.check_reserved(@checkin).must_be_kind_of Array
    end
    it 'Returns a Reservation' do
      @conrad.reserve_room(@checkin, @checkout)
      first_reservation = @conrad.check_reserved(@checkin)[0]
      first_reservation.must_be_instance_of Hotels::Reservation
    end
    it 'Returns the correct number of Reservations in Array' do
      @conrad.reserve_room(@checkin, @checkout)
      @conrad.reserve_room(@checkin)
      @conrad.reserve_room(@checkout)
      assert_equal 2, @conrad.check_reserved(@checkin).length
    end
    it 'Cannot reserve more than 20 rooms for a date' do
      20.times { @conrad.reserve_room(@checkin) }
      assert_nil @conrad.reserve_room(@checkin)
    end
  end # ------------------------- describe #check_reserved block

  describe '#total_cost' do
    it 'Returns an Integer' do
      @conrad.reserve_room(@checkin, @checkout)
      first_reservation = @conrad.reservations[0]
      @conrad.total_cost(first_reservation).must_be_kind_of Integer
    end
    it 'Returns the correct value for a given Reservation' do
      @conrad.reserve_room(@checkin, @checkout)
      assert_equal 800, @conrad.total_cost(@conrad.reservations[0])
    end
    it 'Returns the correct value for a given Reservation ID' do
      @conrad.reserve_room(@checkin, @checkout)
      @conrad.reserve_room(@checkin)
      @conrad.reserve_room(@checkout)
      reservation_id = @conrad.reservations[1].id
      assert_equal 200, @conrad.total_cost(reservation_id)
    end
    it 'Returns nil if no Reservation exists' do
      dne_reservation = @conrad.reservations[0]
      assert_nil @conrad.total_cost(dne_reservation)
    end
    it 'Returns nil if given an incorrect Reservation ID' do
      @conrad.reserve_room(@checkin)
      assert_nil @conrad.total_cost('20171031ABCEDFGHIJ0123456789')
    end
  end # ------------------------- describe #total_cost block
end # ------------------------- describe Hotels::Hotel block
