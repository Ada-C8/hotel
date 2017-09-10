require_relative 'spec_helper'

describe Hotels::Hotel do
  before do
    @conrad = Hotels::Hotel.new('Conrad')
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
    it 'Has a collection of Blocks' do
      @conrad.blocks.must_be_kind_of Array
    end
    it 'Should initialize with no Blocks' do
      @conrad.reservations.must_be_empty
    end
  end # ------------------------- describe #initialize block

  describe '#list_all_rooms' do
    it 'Returns a list of rooms' do
      @conrad.list_all_rooms.must_be_kind_of Array
    end
    it 'Must contain 20 data entries' do
      assert_equal 20, @conrad.list_all_rooms.length
    end
    it 'Should contain room names (String)' do
      @conrad.list_all_rooms[0].must_be_kind_of String
    end
    it 'Should contain a legitimate room name' do
      name = 'Room 1'
      @conrad.list_all_rooms.include?(name).must_equal true
    end
  end # ------------------------- describe #list_all_rooms block

  describe '#reserve_room(checkin, checkout = nil)' do
    it 'Returns a new Reservation' do
      reservation = @conrad.reserve_room(@checkin, @checkout)
      reservation.must_be_instance_of Hotels::Reservation
    end
    it 'Adds a new Reservation to the @reservations Array' do
      @conrad.reserve_room(@checkin, @checkout)
      assert_equal 1, @conrad.reservations.length
    end
    it 'Reserves a Room for the correct number of nights' do
      nights = @conrad.reserve_room(@checkin, @checkout).dates.length
      assert_equal 4, nights
    end
    it 'Will not allow users to book a duplicate room' do
      20.times { @conrad.reserve_room(@checkin) }
      rooms = @conrad.reservations.map(&:rooms).flatten
      assert_equal 20, rooms.uniq.length
    end
    it 'Allows users to check-in on the check-out night of 20 reservations' do
      20.times { @conrad.reserve_room(@checkin, @checkout) }
      @conrad.reserve_room(@checkout)
      assert_equal 21, @conrad.reservations.length
    end
    it 'Will raise an error if trying to book a room on a full day' do
      20.times { @conrad.reserve_room(@checkin, @checkout) }
      proc {
        @conrad.reserve_room(@checkin, @checkout)
      }.must_raise ArgumentError
    end
    it 'Cannot reserve rooms that have been set for a block' do
      4.times { @conrad.book_block(5, @checkin, @checkout) }
      proc {
        @conrad.reserve_room(@checkin, @checkout)
      }.must_raise ArgumentError
    end
  end # ------------------------- describe #reserve_room block

  describe '#list_reservations(date)' do
    it 'Returns an Array' do
      @conrad.list_reservations(@checkin).must_be_kind_of Array
    end
    it 'Returns no Reservations initially' do
      @conrad.list_reservations(@checkin)
      assert_nil @conrad.list_reservations(@checkin)[0]
    end
    it 'Returns Reservations inside the Array' do
      @conrad.reserve_room(@checkin, @checkout)
      first_reservation = @conrad.list_reservations(@checkin)[0]
      first_reservation.must_be_instance_of Hotels::Reservation
    end
    it 'Returns the correct number of Reservations in Array' do
      @conrad.reserve_room(@checkin, @checkout)
      @conrad.reserve_room(@checkin)
      @conrad.reserve_room(@checkout)
      @conrad.book_block(5, @checkin, @checkout)
      @conrad.reserve_block(@conrad.blocks[0].block_id, 1)
      assert_equal 3, @conrad.list_reservations(@checkin).length
    end
  end # ------------------------- describe #list_reservations block

  describe '#unreserved?(checkin, checkout)' do
    it 'Returns a full Array without reservations' do
      @conrad.book_block(5, @checkin, @checkout)
      free_rooms = @conrad.unreserved?(@checkin, @checkout)
      free_rooms = free_rooms[0].values.flatten
      assert_equal 20, free_rooms.length
    end
    it 'Produces an Array of Hashes with Dates and unreserved Rooms' do
      free_rooms = @conrad.unreserved?(@checkin, @checkout)
      free_rooms.must_be_kind_of Array
      free_rooms[0].must_be_kind_of Hash
      free_rooms[0].keys[0].must_be_kind_of Date
      free_rooms[0].values.flatten[0].must_be_kind_of Hotels::Room
    end
    it 'Shows the correct free Rooms for a Date' do
      taken = @conrad.reserve_room(@checkin)
      taken_room = taken.rooms[0]
      free_rooms = @conrad.unreserved?(@checkin)
      free_rooms = free_rooms[0].values.flatten
      (free_rooms.include? taken_room).must_equal false
    end
    it 'Shows the correct number of free Rooms for multiple Dates' do
      @conrad.reserve_room(@checkin, @checkout)
      @conrad.reserve_room(@checkin + 1, @checkout)
      @conrad.reserve_room(@checkin + 2, @checkout)
      @conrad.reserve_room(@checkin + 3, @checkout)
      @conrad.reserve_room(@checkout)
      @conrad.reserve_room(@checkin)

      night1 = @conrad.unreserved?(@checkin)[0].values.flatten.length
      night2 = @conrad.unreserved?(@checkin + 1)[0].values.flatten.length
      night3 = @conrad.unreserved?(@checkin + 2)[0].values.flatten.length
      night4 = @conrad.unreserved?(@checkin + 3)[0].values.flatten.length
      night5 = @conrad.unreserved?(@checkout)[0].values.flatten.length

      assert_equal 18, night1
      assert_equal 18, night2
      assert_equal 17, night3
      assert_equal 16, night4
      assert_equal 19, night5
    end
  end # ------------------------- describe #unreserved? block

  describe '#book_block(checkin, checkout = nil, room_count)' do
    it 'Creates a collection of Rooms' do
      block = @conrad.book_block(2, @checkin, @checkout)
      rooms = block.rooms
      rooms.must_be_kind_of Array
      rooms.wont_be_empty
      rooms[0].must_be_kind_of Hotels::Room
      assert_equal 2, rooms.length
    end
    it 'Can only block 1-5 rooms' do
      proc {
        @conrad.book_block(0, @checkin, @checkout)
      }.must_raise ArgumentError
      proc {
        @conrad.book_block(6, @checkin, @checkout)
      }.must_raise ArgumentError
    end
    it 'Will not be added to the @reservations list' do
      @conrad.reserve_room(@checkin, @checkout)
      block = @conrad.book_block(1, @checkin, @checkout)
      room = block.rooms[0]
      assert_equal 1, @conrad.reservations.length
      assert_equal 19, @conrad.list_unreserved_rooms(@checkin).length
      @conrad.reservations.include?(room).must_equal false
    end
    it 'Cannot block rooms when there are no rooms available' do
      proc {
        20.times { @conrad.reserve_room(@checkin, @checkout) }
        @conrad.book_block(1, @checkin, @checkout)
      }.must_raise ArgumentError
    end
    it 'Will have a discounted total price compared to reservations' do
      reservation = @conrad.reserve_room(@checkin, @checkout)
      block = @conrad.book_block(1, @checkin, @checkout)
      assert reservation.total_cost != block.total_cost
      assert_equal (reservation.total_cost * 0.5), block.total_cost
    end
  end # ------------------------- describe #book_block block

  describe '#check_block(_block_id)' do
    it 'Returns true if there are rooms remaining' do
      @conrad.book_block(5, @checkin, @checkout)
      check = @conrad.check_block(@conrad.blocks[0].block_id)
      assert_equal true, check
      @conrad.reserve_block(@conrad.blocks[0].block_id, 3)
      check = @conrad.check_block(@conrad.blocks[0].block_id)
      assert_equal true, check
    end
    it 'Raises an ArgumentError if there are no rooms remaining' do
      @conrad.book_block(5, @checkin, @checkout)
      @conrad.reserve_block(@conrad.blocks[0].block_id, 5)
      proc {
        @conrad.reserve_block(@conrad.blocks[0].block_id, 5)
      }.must_raise ArgumentError
    end
  end # ------------------------- describe #check_block block

  describe '#reserve_block(block_id, room_count)' do
    it 'Creates a new Reservation' do
      @conrad.book_block(5, @checkin, @checkout)
      reserve_block = @conrad.reserve_block(@conrad.blocks[0].block_id, 1)
      reserve_block.must_be_kind_of Hotels::Reservation
      assert_equal 1, @conrad.reservations.length
    end
    it 'Matches the date of its block' do
      original_block = @conrad.book_block(5, @checkin, @checkout)
      reserve_block = @conrad.reserve_block(@conrad.blocks[0].block_id, 1)
      assert_equal original_block.dates, reserve_block.dates
    end
    it 'Cannot reserve more rooms than noted in the block booking' do
      @conrad.book_block(5, @checkin, @checkout)
      @conrad.reserve_block(@conrad.blocks[0].block_id, 4)
      proc {
        @conrad.reserve_block(@conrad.blocks[0].block_id, 3)
      }.must_raise ArgumentError
    end
  end # ------------------------- describe #reserve_block block
end # ------------------------- describe Hotels::Hotel block
