require_relative 'spec_helper'
# require 'pry'
describe 'Hotel' do
  before do
    @hotel = Hotel::Hotel.new
  end

  describe 'initialize' do
    it 'creates an instance of Hotel' do
      @hotel.must_be_instance_of Hotel::Hotel
    end

    it 'creates a hash of rooms' do
      @hotel.rooms.must_be_kind_of Array
    end

    it 'creates an array of reservations' do
      @hotel.reservations.must_be_kind_of Array
    end

  end

  describe 'make_reservation' do
    it 'creates a reservation object with two dates and pushes to reservations' do
      @hotel.make_reservation(Date.new(2018,9,12), Date.new(2018,9,15)).must_be_kind_of Array
    end
    it 'creates a reservation object with one date and pushes to reservations' do
      @hotel.make_reservation(Date.new(2018,9,12)).must_be_kind_of Array
    end
    it 'returns an array of reservation objects' do
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
      @hotel.make_reservation(@date1 , @date2)
      # @hotel.reservations.each do |reservation|
      #   puts reservation
      #   puts reservation.room_number
      #   puts reservation.daterange.beginning
      #   puts reservation.daterange.ending
      #   puts "<ending"
      # end
      #@hotel.view_available(Date.new(2018,9,15)).must_respond_to :date1
      @hotel.view_available(@date1).must_be_kind_of Array
      @hotel.view_available(@date1).must_equal [:room2, :room3, :room4, :room5, :room6, :room7, :room8, :room9, :room10,
        :room11, :room12, :room13, :room14, :room15, :room16, :room17, :room18, :room19, :room20]
      @hotel.view_available(@date1, @date3).must_equal [:room2, :room3, :room4, :room5, :room6, :room7, :room8, :room9, :room10,
        :room11, :room12, :room13, :room14, :room15, :room16, :room17, :room18, :room19, :room20]
      @hotel.view_available(@date3, @date4).must_equal [:room2, :room3, :room4, :room5, :room6, :room7, :room8, :room9, :room10,
        :room11, :room12, :room13, :room14, :room15, :room16, :room17, :room18, :room19, :room20]
      @hotel.make_reservation(@date1, @date2)
      puts @hotel.reservations
      # @hotel.reservations.each do |reservation|
      #   puts reservation
      #   puts reservation.room_number
      # end
      @hotel.view_available(@date1, @date2).must_equal [:room3, :room4, :room5, :room6, :room7, :room8, :room9, :room10,
        :room11, :room12, :room13, :room14, :room15, :room16, :room17, :room18, :room19, :room20]
    end
  end

  describe 'view booked' do
    it 'returns a list of rooms that are booked for a given date' do
      @date1 = Date.new(2018,9,12)
      @date2 = Date.new(2018,9,15)
      @date3 = Date.new(2018,9,13)
      @date4 = Date.new(2018,9,19)
      @hotel.make_reservation(@date1, @date2)
      @hotel.view_booked(@date1).must_be_kind_of Array
      @hotel.view_booked(@date1).must_equal [:room1]
      @hotel.make_reservation(@date1, @date2)
      @hotel.view_booked(@date1).must_equal [:room1, :room2]
    end
  end

  describe 'is_available?' do
    it 'returns true if the room is available for the given date range' do
      @date1 = Date.new(2018,9,12)
      @date2 = Date.new(2018,9,15)
      @hotel.is_available?(:room4, @date1, @date2).must_equal true
      @hotel.make_reservation(@date1 , @date2)
      @hotel.is_available?(:room1, @date1, @date2).must_equal false
    end
  end

  #REFACTOR SINCE CHANGING MAKE_RESERVATION

  describe 'make reservation for available room' do
    before do
      @date1 = Date.new(2018,9,12)
      @date2 = Date.new(2018,9,15)
    end
    # it 'raises BookingError if room is not available' do
    #   @hotel.make_reservation(@date1, @date2)
    #   proc {@hotel.make_reservation(@date1, @date2)}.must_raise BookingError
    # end
    it 'gives a unique id to each reservation' do
      @hotel.make_reservation(@date1, @date2)
      @hotel.make_reservation(@date1, @date2)
      @hotel.make_reservation(@date1, @date2)
      x = 1
      @hotel.reservations.each do |reservation|
        reservation.id.must_equal x
        x+=1
      end
    end

    it 'will  not reserve a room in a block if not intended' do
      @hotel.make_block('Diane', 120, 5, Date.new(2018,9,12))
      @hotel.make_reservation( Date.new(2018,9,12))
      @hotel.reservations[0].room_number.must_equal :room6
    end
  end


#REFACTOR SINCE CHANGING MAKE_RESERVATION
    describe 'make block' do
      it 'returns an array' do
        @hotel.make_block('Diane', 120, 5, Date.new(2018,9,12)).must_be_kind_of Array
      end

      it 'returns an array full of block objects' do
        @hotel.blocks.each do |block|
          block.must_be_kind_of Hotel::Block
        end
      end

      it 'returns a list of blocks that is the right length' do
        @hotel.make_block('Joyce', 100, 5, Date.new(2018,10,10), Date.new(2018,10,12))
      end
      # MAKE AN ACTUAL TEST FOR THIS
      # it 'can make more than one block' do
      #   @hotel.make_block('Diane', Date.new(2018,9,12), 120, 5)
      #   @hotel.make_block('Joyce', Date.new(2018,10,10), Date.new(2018,10,12), 100, 5)
      #   @hotel.make_block('Roni', Date.new(2018,10,10), Date.new(2018,10,12), 100, 5)
      # end

     it 'sends a booking error if there are no rooms available for a block' do
        @hotel.make_block('Lars', 100, 5, Date.new(2018,10,10), Date.new(2018,10,12))
        @hotel.make_block('Clark', 100, 5, Date.new(2018,10,10), Date.new(2018,10,12))
        @hotel.make_block('Joyce', 100, 5, Date.new(2018,10,10), Date.new(2018,10,12))
        @hotel.make_block('Maisie', 100, 5, Date.new(2018,10,10), Date.new(2018,10,12))
        proc{@hotel.make_block('Becca', 100, 5, Date.new(2018,10,10), Date.new(2018,10,12))}.must_raise BookingError
      end

      it 'raises booking error if more than 5 rooms are being blocked' do
        proc{@hotel.make_block('Dionne', 100, 6, Date.new(2018,10,10), Date.new(2018,10,12))}.must_raise BookingError
      end

      it 'will skip over a reserved room to make a block' do
        @hotel.make_block('Ruth', 100, 3, Date.new(2018,10,10), Date.new(2018,10,12))
        @hotel.make_reservation(Date.new(2018,10,10))
        block2 = @hotel.make_block('Bree', 100, 5, Date.new(2018,10,10), Date.new(2018,10,12))
        block2[1].rooms.must_equal [:room5, :room6, :room7, :room8, :room9]
      end

      # it 'will not make a reservation for a blocked room' do
      #   @hotel.make_block('Clem', Date.new(2018,10,10), Date.new(2018,10,12), 100, 3)
      #   proc{@hotel.make_reservation(Date.new(2018,10,10), Date.new(2018,10,11))}.must_raise BookingError
      # end

      it 'will raise a BookingError if you try to make reservation when all of the rooms are blocked' do
        @hotel.make_block('Alec', 100, 5, Date.new(2018,10,10), Date.new(2018,10,12))
        @hotel.make_block('Alanna', 100, 5, Date.new(2018,10,10), Date.new(2018,10,12))
        @hotel.make_block('Molly', 100, 5, Date.new(2018,10,10), Date.new(2018,10,12))
        @hotel.make_block('Claire', 100, 5, Date.new(2018,10,10), Date.new(2018,10,12))
        proc{@hotel.make_reservation(Date.new(2018,10,10), Date.new(2018,10,12))}.must_raise BookingError
      end
    end

    # xdescribe "Show available rooms in a block"
    #   it 'will return available rooms in a given block' do
    #     @hotel.make_block('Sarah', Date.new(2019,11,11), Date.new(2019, 11, 15), 100, 3)
    #     @hotel.make_reservation('Sarah', Date.new(2019,11,11), Date.new(2019, 11, 15))
    #     @hotel.show_available_block.must_equal [:room2, :room3]
    #   end
    # end


end
