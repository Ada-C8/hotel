require_relative 'spec_helper'

describe 'Hotel' do
  before do
    @hotel = Hotel::Hotel.new(20)
  end

  describe '#initialize' do
    it 'Can be instantiated' do
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
      all_rooms = @hotel.all_rooms
      all_rooms.must_be_kind_of Array
      all_rooms.each do |room|
        room.must_be_kind_of Hotel::Room
      end
    end
  end

  describe '#room' do
    it 'returns the Room with corresponding number' do
      room = @hotel.room(4)
      room.must_be_kind_of Hotel::Room
      room.number.must_equal 4
    end

    it 'returns nil if room is not found' do
      @hotel.room(1000).must_equal nil
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

    it 'will not return rooms in a block' do
      # skip
      @hotel.make_reservation('2017-10-14', '2017-10-18')
      @hotel.make_block('2017-10-10', '2017-10-16', 5, 20)
      rooms = @hotel.find_available_rooms('2017-10-14','2017-10-15')

      rooms.length.must_equal 14
    end

    it 'will return rooms in a block when provided block ID' do
      # skip
      block = @hotel.make_block('2017-10-10', '2017-10-16', 5, 20)
      rooms = @hotel.find_available_rooms('2017-10-14','2017-10-15', block.id)

      rooms.length.must_equal 5
    end

    it 'raises an error if dates do not fall within given block' do
      block = @hotel.make_block('2017-08-03', '2017-08-08', 5, 20)

      proc { @hotel.find_available_rooms('2017-10-14', '2017-10-15', block.id)
      }.must_raise InvalidDatesError
    end
  end

  describe '#make_reservation' do
    before do
      @reservation1 = @hotel.make_reservation('2017-09-05', '2017-09-08')
    end
    it 'creates a reservation and adds it to the @reservations array' do
      # As an administrator, I can reserve a room for a given date range
      @reservation1.must_be_kind_of Hotel::Reservation
      @reservation1.checkout.strftime.must_equal '2017-09-08'
    end

    it 'will reserve the first available room' do
      # As an administrator, I can reserve an available room for a given date range
      reservation2 = @hotel.make_reservation('2017-09-05', '2017-09-08')
      @reservation1.room.wont_equal reservation2.room
    end

    it 'will book a room again after a reservation ends' do
      reservation2 = @hotel.make_reservation('2018-09-05', '2018-09-08')

      @reservation1.room.must_equal reservation2.room
    end

    it 'can book two consecutive reservations to the same room' do
      # A reservation is allowed start on the same day that another reservation for the same room ends
      reservation2 = @hotel.make_reservation('2017-09-08', '2017-09-11')

      @reservation1.room.must_equal reservation2.room
    end

    it 'will not book a room that is part of a block' do
      # - If a room is set aside in a block, it is not available for reservation by the general public
      block = @hotel.make_block('2017-08-03', '2017-08-07', 10, 20)
      reservation = @hotel.make_reservation('2017-08-04', '2017-08-05')

      block.rooms.wont_include reservation.room
    end

    it 'will book room in block if provided a block ID' do
      # - As an administrator, I can reserve a room from within a block of rooms
      block = @hotel.make_block('2017-08-03', '2017-08-07', 10, 20)
      reservation = @hotel.make_reservation('2017-08-04', '2017-08-05', block.id)

      block.rooms.must_include reservation.room
    end

    it 'raises NoRoomError if no rooms are available' do
      # Your code should raise an exception when asked to reserve a room that is not available
      proc {
        21.times { @hotel.make_reservation('2017-09-05', '2017-09-08') }
      }.must_raise NoRoomError
    end

    it 'raises NoRoomError if all rooms are in a block' do
      @hotel.make_block('2017-09-05', '2017-09-08', 19, 20)

      proc { @hotel.make_reservation('2017-09-05', '2017-09-08')
      }.must_raise NoRoomError
    end
  end

  describe '#view_reservations' do
    # As an administrator, I can access the list of reservations for a specific date
    it 'returns an array of Reservations' do
      @hotel.make_reservation('2017-10-14', '2017-10-18')
      reservations = @hotel.view_reservations('2017-10-14')

      reservations.must_be_kind_of Array
      reservations.length.must_equal 1
      reservations.each do |reservation|
        reservation.must_be_kind_of Hotel::Reservation
      end
    end
  end

  describe '#make_block' do
    before do
      @block = @hotel.make_block('2017-08-03', '2017-08-07', 10, 20)
    end

    # - As an administrator, I can create a block of rooms
    it 'returns a new Block object' do
      @block.must_be_kind_of Hotel::Block
    end

    it 'adds to @blocks array' do
      @hotel.blocks.length.must_equal 1
    end

    it 'fills block with available rooms only' do
      # - The collection of rooms should only include rooms that are available for the given date range
      3.times { @hotel.make_reservation('2017-10-05', '2017-10-07') }
      new_block = @hotel.make_block('2017-10-03', '2017-10-07', 10, 20)
      reserved = @hotel.view_reservations('2017-10-06')

      reserved.each do |reservation|
        new_block.rooms.wont_include reservation.room
      end
    end

    it 'will not overlap multiple blocks' do
      # - If a room is set aside in a block, it cannot be included in another block
      block2 = @hotel.make_block('2017-08-03', '2017-08-07', 5, 20)

      @block.rooms.each do |room|
        block2.rooms.wont_include room
      end
    end

    it 'raises an error when there are not enough rooms to fill a block' do
      proc { block2 = @hotel.make_block('2017-08-03', '2017-08-07', 11, 20)
      }.must_raise NoRoomError
    end
  end
end

# - As an administrator, I can check whether a given block has any rooms available

# TODO: lots and lots of edge case testing
