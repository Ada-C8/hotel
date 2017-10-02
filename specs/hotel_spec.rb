require_relative 'spec_helper'

describe 'Hotel' do
  before do
    @hotel = Hotel::Hotel.new(20)
  end

  describe '#initialize' do
    it 'Can be instantiated' do
      @hotel.must_be_kind_of Hotel::Hotel
      @hotel.reservations.must_equal []
      @hotel.blocks.must_equal []
    end

    it 'Creates an array of rooms' do
      @hotel.rooms.must_be_kind_of Array
      @hotel.rooms.length.must_equal 20
      @hotel.rooms.each do |room|
        room.must_be_kind_of Hotel::Room
      end
    end

    it 'Can be initialized with 0 rooms' do
      hotel = Hotel::Hotel.new(0)
      hotel.rooms.must_equal []
    end

    it 'Can be initialized with 1 room' do
      hotel = Hotel::Hotel.new(1)
      hotel.rooms.length.must_equal 1
      hotel.rooms[0].must_be_kind_of Hotel::Room
    end

    it 'raises NoMethodError if passed anything but an Integer' do
      proc {
        Hotel::Hotel.new('hi')
      }.must_raise NoMethodError

      proc {
        Hotel::Hotel.new(nil)
      }.must_raise NoMethodError

      proc {
        Hotel::Hotel.new(4.0)
      }.must_raise NoMethodError
    end
  end

  describe 'rooms' do
    describe '@rooms' do
      # As an administrator, I can access the list of all of the rooms in the hotel
      it 'Returns an array of all room numbers' do
        all_rooms = @hotel.rooms
        all_rooms.must_be_kind_of Array
        all_rooms.each do |room|
          room.must_be_kind_of Hotel::Room
        end
      end

      it 'returns an empty array if there are no rooms' do
        all_rooms = Hotel::Hotel.new(0).rooms
        all_rooms.must_equal []
      end

      it 'returns a single-element array if there is 1 room' do
        all_rooms = Hotel::Hotel.new(1).rooms
        all_rooms.length.must_equal 1
        all_rooms[0].must_be_kind_of Hotel::Room
      end
    end

    describe '#room' do
      it 'returns the Room with corresponding number' do
        room = @hotel.room(4)
        room.must_be_kind_of Hotel::Room
        room.number.must_equal 4
      end

      it 'returns nil if room is not found' do
        assert_nil @hotel.room(1000)
        assert_nil @hotel.room('hi')
        assert_nil @hotel.room(5.5)
        assert_nil @hotel.room(nil)
        assert_nil @hotel.room(true)
        assert_nil @hotel.room([4,0])
      end
    end

    describe '#find_available_rooms' do
      # As an administrator, I can view a list of rooms that are not reserved for a given date range
      it 'returns an array of rooms' do
        rooms = @hotel.find_available_rooms('2017-09-05', '2017-09-09')
        rooms.must_be_kind_of Array
        rooms.each do |room|
          room.must_be_kind_of Hotel::Room
        end
      end

      it 'returns only available rooms' do
        @hotel.make_reservation('2017-10-14', '2017-10-18')
        @hotel.make_reservation('2017-10-14', '2017-10-18')
        @hotel.make_reservation('2018-10-14', '2018-10-18')
        rooms = @hotel.find_available_rooms('2017-10-14', '2017-10-18')

        rooms.length.must_equal 18
      end

      it 'returns an empty array if no rooms are available' do
        20.times {@hotel.make_reservation('2017-10-14', '2017-10-18')}
        rooms = @hotel.find_available_rooms('2017-10-14', '2017-10-18')
        rooms.must_equal []
      end

      it 'will not return rooms in a block' do
        @hotel.make_reservation('2017-10-14', '2017-10-18')
        @hotel.make_block('2017-10-10', '2017-10-16', 5, 20)
        @hotel.make_block('2017-11-10', '2017-11-16', 5, 20)
        rooms = @hotel.find_available_rooms('2017-10-14','2017-10-15')

        rooms.length.must_equal 14
      end

      it 'returns an empty array if all rooms are in a block' do
        @hotel.make_block('2017-10-10', '2017-10-16', 20, 20)
        rooms = @hotel.find_available_rooms('2017-10-14','2017-10-15')

        rooms.must_equal []
      end

      it 'will return rooms in a block when provided block ID' do
        block = @hotel.make_block('2017-10-10', '2017-10-16', 5, 20)
        rooms = @hotel.find_available_rooms('2017-10-14','2017-10-15', block.id)

        rooms.length.must_equal 5
      end

      it 'raises an error if passed invalid dates' do
        proc {
          @hotel.find_available_rooms(1,2)
        }.must_raise ArgumentError

        proc {
          @hotel.find_available_rooms('tomorrow','next friday')
        }.must_raise ArgumentError

        proc {
          @hotel.find_available_rooms('2017-02-30','2017-04-98')
        }.must_raise ArgumentError
      end

      it 'raises an error if block is not found' do
        proc {
          @hotel.find_available_rooms('2017-10-14','2017-10-15', 'B10141991')
        }.must_raise NoBlockError

      end

      it 'raises an error if dates do not fall within given block' do
        block = @hotel.make_block('2017-08-03', '2017-08-08', 5, 20)

        proc {
          @hotel.find_available_rooms('2017-10-14', '2017-10-15', block.id)
        }.must_raise DatesError
      end

      it 'raises an error if dates are out of order' do
        proc {
          @hotel.find_available_rooms('2017-08-23', '2017-08-08')
        }.must_raise DatesError
      end

      it 'raises an error if dates do not span at least 1 night' do
        proc {
          @hotel.find_available_rooms('2017-08-08', '2017-08-08')
        }.must_raise DatesError
      end
    end
  end

  describe 'reservations' do
    describe '#make_reservation' do
      before do
        @reservation = @hotel.make_reservation('2017-09-05', '2017-09-08')
      end

      it 'creates a reservation and adds it to the @reservations array' do
        # As an administrator, I can reserve a room for a given date range
        @reservation.must_be_kind_of Hotel::Reservation
        @reservation.checkout.strftime.must_equal '2017-09-08'
      end

      it 'will reserve the first available room' do
        # As an administrator, I can reserve an available room for a given date range
        reservation2 = @hotel.make_reservation('2017-09-05', '2017-09-08')
        @reservation.room.wont_equal reservation2.room
      end

      it 'will book a room again after a reservation ends' do
        reservation2 = @hotel.make_reservation('2018-09-05', '2018-09-08')

        @reservation.room.must_equal reservation2.room
      end

      it 'can book two consecutive reservations to the same room' do
        # A reservation is allowed start on the same day that another reservation for the same room ends
        reservation2 = @hotel.make_reservation('2017-09-08', '2017-09-11')

        @reservation.room.must_equal reservation2.room
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

      it 'raises DatesError if reservation does not fall fully within block' do
        block = @hotel.make_block('2017-08-03', '2017-08-08', 5, 10)
        proc {
          @hotel.make_reservation('2017-08-06', '2017-08-10', block.id)
        }.must_raise DatesError
      end

      it 'raises ArgumentError if passed invalid dates' do
        proc {
          @hotel.make_reservation('cat','bug')
        }.must_raise ArgumentError

        proc {
          @hotel.make_reservation(1,2)
        }.must_raise ArgumentError

        proc {
          @hotel.make_reservation('2019-02-40','2019-02-45')
        }.must_raise ArgumentError
      end

      it 'raises DatesError if dates are out of order' do
        proc {
          reservation = @hotel.make_reservation('2017-09-08', '2017-09-05')
        }.must_raise DatesError
      end

      it 'raises DatesError if reservation does not span at least 1 night' do
        proc {
          @hotel.make_reservation('2017-10-14','2017-10-14')
        }.must_raise DatesError
      end

      it 'raises NoBlockError if passed nonexistent block' do
        proc {
          @hotel.make_reservation('2017-09-05', '2017-09-08', 'catbug')
        }.must_raise NoBlockError
      end

      it 'raises NoRoomError if no rooms are available' do
        # Your code should raise an exception when asked to reserve a room that is not available
        proc {
          21.times { @hotel.make_reservation('2017-09-05', '2017-09-08') }
        }.must_raise NoRoomError
      end

      it 'raises NoRoomError if all rooms are in a block' do
        @hotel.make_block('2017-09-05', '2017-09-08', 19, 20)

        proc {
          @hotel.make_reservation('2017-09-05', '2017-09-08')
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

      it 'returns all Reservations' do
        10.times { @hotel.make_reservation('2017-10-14', '2017-10-18') }
        reservations = @hotel.view_reservations('2017-10-14')

        reservations.length.must_equal 10
        reservations.each do |reservation|
          reservation.must_be_kind_of Hotel::Reservation
        end
      end

      it 'returns Reservations inside and outside of blocks' do
        block = @hotel.make_block('2017-08-03', '2017-08-10', 10, 25)
        @hotel.make_reservation('2017-08-03', '2017-08-10', block.id)
        @hotel.make_reservation('2017-08-03', '2017-08-10')
        reservations = @hotel.view_reservations('2017-08-06')

        reservations.length.must_equal 2
      end

      it 'returns an empty array when there are no reservations' do
        @hotel.view_reservations('2000-01-01').must_equal []
      end

      it 'wont display rooms in blocks that are not reserved' do
        @block = @hotel.make_block('2017-08-03', '2017-08-07', 10, 20)

        @hotel.view_reservations('2017-08-06').must_equal []
      end

      it 'raises an ArgumentError when given invalid dates' do
        proc {
          @hotel.view_reservations('coffee')
        }.must_raise ArgumentError

        proc {
          @hotel.view_reservations('9999-99-99')
        }.must_raise ArgumentError
      end
    end
  end

  describe 'blocks' do
    before do
      @block = @hotel.make_block('2017-08-03', '2017-08-07', 10, 20)
    end

    describe '#make_block' do
      # - As an administrator, I can create a block of rooms
      it 'returns a new Block object' do
        @block.must_be_kind_of Hotel::Block
      end

      it 'can make a block for 1 night' do
        block = @hotel.make_block('2017-08-03', '2017-08-04', 10, 20)

        block.dates.length.must_equal 1
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

      it 'can begin a block the day another block ends' do
        block2 = @hotel.make_block('2017-08-07', '2017-08-10', 10, 20)

        @block.rooms.must_equal block2.rooms
      end

      it 'raises NoRoomError when there are not enough rooms to fill a block' do
        proc {
          @hotel.make_block('2017-08-03', '2017-08-07', 11, 20)
        }.must_raise NoRoomError
      end

      it 'raises ArgumentError error when passed invalid dates' do
        proc {
          @hotel.make_block('Augustish', 'Later', 5, 25)
        }.must_raise ArgumentError

        proc {
          @hotel.make_block('2017-14-14', '2017-15-15', 5, 25)
        }.must_raise ArgumentError
      end

      it 'raises DatesError when dates are out of order' do
        proc {
          @hotel.make_block('2017-09-07', '2017-09-05', 5, 25)
        }.must_raise DatesError
      end

      it 'raises DatesError when dates do not span at least 1 night' do
        proc {
          @hotel.make_block('2017-08-03', '2017-08-03', 10, 20)
        }.must_raise DatesError
      end

      it 'raises DiscountError when passed discount greater than 100%' do
        proc {
          @hotel.make_block('2017-09-07', '2017-09-10', 5, 125)
        }.must_raise DiscountError
      end

      it 'raises DiscountError when passed discount below 0%' do
        proc {
          @hotel.make_block('2017-09-07', '2017-09-10', 5, -25)
        }.must_raise DiscountError
      end

      it 'raises ArgumentError when passed invalid discount' do
        proc {
          @hotel.make_block('2017-09-07', '2017-09-10', 5, 'free')
        }.must_raise ArgumentError
      end

      it 'raises error when passed invalid rooms number' do
        proc {
          @hotel.make_block('2017-09-07', '2017-09-10', true, 25)
        }.must_raise ArgumentError

        proc {
          @hotel.make_block('2017-09-07', '2017-09-10', 0.5, 25)
        }.must_raise ArgumentError

        proc {
          @hotel.make_block('2017-09-07', '2017-09-10', 'hello', 25)
        }.must_raise ArgumentError
      end
    end

    describe '#find_rooms_not_in_blocks' do
      it 'returns array of rooms' do
        rooms = @hotel.find_rooms_not_in_blocks('2017-10-14', '2017-10-18')
        rooms.must_be_kind_of Array
      end

      it 'returns rooms that are not in block' do
        rooms = @hotel.find_rooms_not_in_blocks('2017-08-05', '2017-08-07')

        rooms.each do |room|
          @block.rooms.wont_include room
        end

        rooms.length.must_equal 10
      end

      it 'returns rooms that are reserved, but not in blocks' do
        @hotel.make_reservation('2017-08-03', '2017-08-07')

        rooms = @hotel.find_rooms_not_in_blocks('2017-08-05', '2017-08-07')

        rooms.length.must_equal 10
      end

      it 'returns empty array if all rooms are in block' do
        @hotel.make_block('2017-08-03', '2017-08-07', 10, 20)

        rooms = @hotel.find_rooms_not_in_blocks('2017-08-03', '2017-08-07')

        rooms.must_equal []
      end

      it 'raises DatesError if dates are out of order' do
        proc {
          @hotel.find_rooms_not_in_blocks('2017-09-15', '2017-09-05')
        }.must_raise DatesError
      end

      it 'raises ArgumentError if passed invalid date' do
        proc {
          @hotel.find_rooms_not_in_blocks('sea','HAWKS')
        }.must_raise ArgumentError

        proc {
          @hotel.find_rooms_not_in_blocks('2017-08-06','HAWKS')
        }.must_raise ArgumentError

        proc {
          @hotel.find_rooms_not_in_blocks('2017-08-06','HAWKS')
        }.must_raise ArgumentError
      end

      it 'raises DatesError if dates do not span at least 1 night' do
        proc {
          @hotel.find_rooms_not_in_blocks('2017-08-06','2017-08-06')
        }.must_raise DatesError
      end
    end

    describe '#block_availability?' do
      # - As an administrator, I can check whether a given block has any rooms available
      it 'returns true if there are unbooked rooms within block for given dates' do
        check = @hotel.block_availability?('2017-08-05', '2017-08-07', @block.id)
        check.must_equal true
      end

      it 'returns false if there are no unbooked rooms within block for given dates' do
        10.times { @hotel.make_reservation('2017-08-03', '2017-08-07', @block.id) }
        check = @hotel.block_availability?('2017-08-05', '2017-08-07', @block.id)
        check.must_equal false
      end

      it 'raises NoBlockError if block cannot be found' do
        proc {
          @hotel.block_availability?('2017-10-14', '2017-10-15', 'bad block')
        }.must_raise NoBlockError
      end

      it 'raises DatesError if the dates do not fall within the block' do
        proc {
          @hotel.block_availability?('2017-10-14','2017-10-15', @block.id)
        }.must_raise DatesError
      end

      it 'raises DatesError if the dates are out of order' do
        proc {
          @hotel.block_availability?('2017-11-14','2017-10-15', @block.id)
        }.must_raise DatesError
      end

      it 'raises DatesError if the dates do not span at least 1 night' do
        proc {
          @hotel.block_availability?('2017-10-14','2017-10-14', @block.id)
        }.must_raise DatesError
      end

      it 'raises ArgumentError if passed invalid dates' do
        proc {
          @hotel.block_availability?('sea','HAWKS')
        }.must_raise ArgumentError
      end
    end

    describe '#block_exists?' do
      it 'returns true if block w/ given ID exists' do
        @hotel.block_exists?(@block.id).must_equal true
      end

      it 'returns false if block w/ given ID does not exist' do
        @hotel.block_exists?('B09051234').must_equal false
        @hotel.block_exists?(2).must_equal false
        @hotel.block_exists?(nil).must_equal false
        @hotel.block_exists?('hello').must_equal false
      end
    end
  end
end
