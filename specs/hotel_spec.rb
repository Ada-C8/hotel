require_relative 'spec_helper'
# require 'pry'
describe 'Hotel' do
  before do
    @hotel = Hotel::Hotel.new
    @date1 = Date.new(2018,9,12)
    @date2 = Date.new(2018,9,15)
    @date3 = Date.new(2018,9,13)
    @date4 = Date.new(2018,9,19)
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
      @hotel.make_reservation(date1: @date1, date2: @date2).must_be_kind_of Array
    end
    it 'creates a reservation object with one date and pushes to reservations' do
      @hotel.make_reservation(date1: @date1).must_be_kind_of Array
    end
    it 'returns an array of reservation objects' do
      @hotel.reservations.each do |reservation|
        reservation.must_be_instance_of Hotel::Reservation
      end
    end
end
  describe 'view available' do
    it 'returns a list of rooms that are available for a given date' do

      @hotel.make_reservation(date1: @date1 , date2: @date2)
      @hotel.view_available(date1: @date1).must_be_kind_of Array
      @hotel.view_available(date1: @date1).must_equal [:room2, :room3, :room4, :room5, :room6, :room7, :room8, :room9, :room10,
        :room11, :room12, :room13, :room14, :room15, :room16, :room17, :room18, :room19, :room20]
      @hotel.view_available(date1: @date1, date2: @date3).must_equal [:room2, :room3, :room4, :room5, :room6, :room7, :room8, :room9, :room10,
        :room11, :room12, :room13, :room14, :room15, :room16, :room17, :room18, :room19, :room20]
      @hotel.view_available(date1: @date3, date2: @date4).must_equal [:room2, :room3, :room4, :room5, :room6, :room7, :room8, :room9, :room10,
        :room11, :room12, :room13, :room14, :room15, :room16, :room17, :room18, :room19, :room20]
      @hotel.make_reservation(date1: @date1, date2: @date2)
      @hotel.view_available(date1: @date1, date2: @date2).must_equal [:room3, :room4, :room5, :room6, :room7, :room8, :room9, :room10,
        :room11, :room12, :room13, :room14, :room15, :room16, :room17, :room18, :room19, :room20]
    end
  end

  describe 'view booked' do
    it 'returns a list of rooms that are booked for a given date' do
      @hotel.make_reservation(date1: @date1, date2: @date2)
      @hotel.view_booked(@date1).must_be_kind_of Array
      @hotel.view_booked(@date1).must_equal [:room1]
      @hotel.make_reservation(date1: @date1, date2: @date2)
      @hotel.view_booked(@date1).must_equal [:room1, :room2]
    end
  end

  describe 'is_available?' do
    it 'returns true if the room is available for the given date range' do
      @date1 = Date.new(2018,9,12)
      @date2 = Date.new(2018,9,15)
      @hotel.is_available?(:room4, @date1, @date2).must_equal true
      @hotel.make_reservation(date1: @date1 , date2: @date2)
      @hotel.is_available?(:room1, @date1, @date2).must_equal false
    end
  end

  #REFACTOR SINCE CHANGING MAKE_RESERVATION

  describe 'make reservation for available room' do

    # it 'raises BookingError if room is not available' do
    #   @hotel.make_reservation(@date1, @date2)
    #   proc {@hotel.make_reservation(@date1, @date2)}.must_raise BookingError
    # end

    it 'gives a unique id to each reservation' do
      @hotel.make_reservation(date1: @date1, date2:@date2)
      @hotel.make_reservation(date1: @date1, date2:@date2)
      @hotel.make_reservation(date1: @date1, date2:@date2)
      x = 1
      @hotel.reservations.each do |reservation|
        reservation.id.must_equal x
        x+=1
      end
    end

    # it 'will  not reserve a room in a block if no partyname is supplied for a one night stay' do
    #   @hotel.make_block('Diane', 120, 5, @date1)
    #   @hotel.make_reservation(date1: @date1)
    #   @hotel.reservations[0].room_number.must_equal :room6
    # end


    it 'will  not reserve a room in a block if no partyname is supplied for a multinight stay' do
      @hotel.make_block('Diane', 120, 5, @date1, @date2)
      @hotel.make_reservation(date1: @date1)
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
        @hotel.make_block('Joyce', 100, 5, @date1, @date2)
      end

      # it 'can make more than one block' do
      #   @hotel.make_block('Diane', 120, 3, @date1)
      #   @hotel.make_block('Joyce', 100, 4, @date1, @date)
      #   @hotel.make_block('Roni', 100, 2, @date1, @date)
      #   @hotel.view_available_in_block(partyname: 'Roni').must_equal [:room8, :room9]
      # end

     it 'sends a booking error if there are no rooms available for a block' do
        @hotel.make_block('Lars', 100, 5, @date1, @date2)
        @hotel.make_block('Clark', 100, 5, @date1, @date2)
        @hotel.make_block('Joyce', 100, 5, @date1, @date2)
        @hotel.make_block('Maisie', 100, 5, @date1, @date2)
        proc{@hotel.make_block('Becca', 100, 5, @date1, @date2)}.must_raise BookingError
      end

      it 'raises booking error if more than 5 rooms are being blocked' do
        proc{@hotel.make_block('Dionne', 100, 6, @date1, @date2)}.must_raise BookingError
      end

      it 'will skip over a reserved room to make a block' do
        @hotel.make_block('Ruth', 100, 3, @date1, @date2)
        # binding.pry
        @hotel.make_reservation(date1: @date1)
        block2 = @hotel.make_block('Bree', 100, 5, @date1, @date2)
        block2[1].rooms.must_equal [:room5, :room6, :room7, :room8, :room9]
      end

      it 'will raise a BookingError if you try to make reservation when all of the rooms are blocked' do
        @hotel.make_block('Alec', 100, 5, @date1, @date2)
        @hotel.make_block('Alanna', 100, 5, @date1, @date2)
        @hotel.make_block('Molly', 100, 5, @date1, @date2)
        @hotel.make_block('Claire', 100, 5, @date1, @date2)
        proc{@hotel.make_reservation(date1: @date1, date2: @date2)}.must_raise BookingError
      end


    end

#BREAK UP AND MAKE MORE EDGE CASES
#WHAT IF ITS A BLOCK RESERVATION BUT THERE IS ONLY ONE DATE???
    describe 'make reservation in a block' do
      it 'makes a reservation inside a block' do
        @hotel.make_block('IzzieP', 120, 3, @date1, @date2 )
        @res = @hotel.make_reservation(date1: @date1, date2: @date2, partyname: 'IzzieP')
        @res[0].must_be_instance_of Hotel::Reservation
        @res[0].partyname.must_equal 'IzzieP'
        @res[0].cost.must_equal 120
      end

      it 'makes a reservation inside a block for the second room' do
        @hotel.make_block('Tuffanoo', 100, 3, @date1, @date2 )
        @res = @hotel.make_reservation(date1: @date1, date2: @date2, partyname: 'Tuffanoo')
        @res[0].must_be_instance_of Hotel::Reservation
        @res[0].partyname.must_equal 'Tuffanoo'
        @res[0].cost.must_equal 100
        @res[0].room_number.must_equal :room1
        @res2 = @hotel.make_reservation(date1: @date1, date2: @date2, partyname: 'Tuffanoo')
        @res2[1].partyname.must_equal 'Tuffanoo'
        @res2[1].room_number.must_equal :room2
        @res3 = @hotel.make_reservation(date1:@date2, date2:@date2, partyname: 'Tuffanoo')
        @res3[2].room_number.must_equal :room3
      end

      it 'must raise BookingError if there are no rooms left in the block' do
        proc{@hotel.make_reservation(date1:@date2, date2:@date2, partyname:'Tuffanoo')}.must_raise BookingError
      end

      it 'makes a reservation inside a block for a block with one date' do
        @hotel.make_block('Victor', 100, 3, @date1)
        @hotel.make_reservation(partyname: 'Victor')
      end

      it 'makes a reservation inside a block with just block name' do
        @hotel.make_block('Charis', 100, 3, @date1, @date2)
        # binding.pry
        @hotel.make_reservation(partyname: 'Charis')
      end

      it 'makes a reservation inside a one night block with just block name' do
        @hotel.make_block('Isabella', 100, 3, @date1)
        res = @hotel.make_reservation(partyname: 'Isabella')[0]
        res.partyname.must_equal 'Isabella'
        res.cost.must_equal 100
      end
    end

#MORE EDGE CASES
    describe "Show available rooms in a block" do
      it 'will return available rooms in a given block' do
        @hotel.make_block('Sarah', 120, 3, @date1, @date2)
        @hotel.make_reservation(partyname: 'Sarah')
        @hotel.view_available_in_block(partyname: 'Sarah').must_equal [:room2, :room3]
      end

      it 'will return available rooms in a given block if all are available' do
        @hotel.make_block('Alex', 120, 3, @date1, @date2)
        @hotel.view_available_in_block(partyname: 'Alex').must_equal [:room1, :room2, :room3]
      end

      it 'will return the correct rooms for a block if there is more than one block' do
        @hotel.make_block('Diane', 120, 3, @date1)
        @hotel.make_block('Joyce', 100, 4, @date1, @date2)
        @hotel.make_block('Roni', 100, 2, @date1, @date2)
        @hotel.view_available_in_block(partyname: 'Roni').must_equal [:room8, :room9]
      end

      it 'will return an empty list if there are no rooms available in the given block' do
        @hotel.make_block('Diane', 120, 2, @date1)
        @hotel.make_reservation(partyname: 'Diane')
        @hotel.make_reservation(partyname: 'Diane')
        @hotel.view_available_in_block(partyname: 'Diane').length.must_equal 0
      end
    end

end
