require_relative 'spec_helper'

describe Hotels::Hotel do
  before do
    @conrad = Hotels::Hotel.new
    @checkin = Date.new(2017, 10, 31)
    @checkout = Date.new(2017, 11, 4)
  end

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
  end #------------------------- describe #initialize block

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
  end #------------------------- describe #list_rooms block

  describe '#reserve_room' do
    it 'Returns a new Reservation' do
      @conrad.reserve_room(@checkin, @checkout).must_be_instance_of Hotels::Reservation
    end
    it 'Adds a new Reservation to the @reservations Array' do
      @conrad.reserve_room(@checkin, @checkout)
      assert_equal 1, @conrad.reservations.length
    end
    it 'Reserves the room for the correct number of nights' do
      assert_equal 4, @conrad.reserve_room(@checkin, @checkout).dates.length
    end
  end #------------------------- describe #reserve_room block

  describe '#check_reserved' do
    it 'Returns an Array' do
      @conrad.check_reserved(@checkin).must_be_kind_of Array
    end
    it 'Returns an Array of Reservations' do
      @conrad.reserve_room(@checkin, @checkout)
      @conrad.check_reserved(@checkin)[0].must_be_instance_of Hotels::Reservation
    end
    it 'Returns the correct number of Reservations' do
      @conrad.reserve_room(@checkin, @checkout)
      @conrad.reserve_room(@checkin)
      @conrad.reserve_room(@checkout)
      assert_equal 2, @conrad.check_reserved(@checkin).length
    end
  end #------------------------- describe #check_reserved block

  xdescribe '#total_cost' do
    it 'Returns an Integer' do
    end
    it '' do
    end
    it '' do
    end
  end #------------------------- describe #total_cost block
end
# conrad = Hotels::Hotel.new
#
# puts conrad.list_rooms
#
# checkin = Date.new(2017,10,31)
# checkout = Date.new(2017,11,4)
# 3.times do
#   puts conrad.reserve_room(checkin, checkout)
# end
#
# check = Date.new(2017,11,2)
# ap conrad.check_reserved(check)
