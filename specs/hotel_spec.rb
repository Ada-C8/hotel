require_relative 'spec_helper'

describe "My_Hotel::Hotel" do
  before do
    @ritz = My_Hotel::Hotel.new
    @feb1 = Date.civil(2017,2,1)
    @feb3 = Date.civil(2017,2,3)
    @feb5 = Date.civil(2017,2,5)
    @feb6 = Date.civil(2017,2,6)
    @apr3 = Date.civil(2017,4,3)
    @apr6 = Date.civil(2017,4,6)
    @may6 = Date.civil(2017,5,6)
  end

  describe "initialize" do
    it "creates an instance of Hotel" do
      @ritz.must_be_kind_of My_Hotel::Hotel
      @ritz.rooms.must_be_kind_of Hash
      @ritz.rooms.length.must_equal 20
      @ritz.all_reservations.must_be_empty
      @ritz.all_reservations.must_be_kind_of Array
      @ritz.all_blocks.must_be_empty
      @ritz.all_reservations.must_be_kind_of Array
    end
  end

  describe "display_rooms" do
    it "list of all of the rooms in the hotel" do
      @ritz.display_rooms.must_be_kind_of Array
    end
  end


  describe "make_reservation" do
    it "can make a multi-night reservation" do
      @ritz.must_be_kind_of My_Hotel::Hotel
      holiday = @ritz.make_reservation(@feb1, @feb5)
      holiday.must_be_kind_of My_Hotel::Reservation
    end

    it "can make a one-night reservation" do
      @ritz.must_be_kind_of My_Hotel::Hotel
      holiday = @ritz.make_reservation(@feb1, @feb1)
      holiday.must_be_kind_of My_Hotel::Reservation
    end

    it "raises an argument if you try to reserve a room and none is available" do
      20.times do
        @ritz.make_reservation(@feb1, @feb5)
        @ritz.find_all_unreserved_rooms(@feb1..@feb5)
      end
      proc{@ritz.make_reservation(@feb1, @feb5).must_raise ArgumentError}
    end

    it "updates the list_of_reservations" do
      @ritz.make_reservation(@feb1, @feb5)
      @ritz.all_reservations.must_be_kind_of Array
      @ritz.all_reservations.length.must_equal 1
      @ritz.make_reservation(@feb1, @feb3)
      @ritz.all_reservations.length.must_equal 2
    end
  end

  describe "unique_reservation_id?" do
    it "returns false if reservation_id is not unique" do
      first =  @ritz.make_reservation(@feb1, @feb5)
      second = first.dup
      @ritz.unique_reservation_id?(second).must_equal false
    end

    it "returns true if reservation_id is unique" do
      @ritz.make_reservation(@feb1, @feb5)
      second = My_Hotel::Reservation.new(@feb1, @feb5)
      @ritz.unique_reservation_id?(second).must_equal true
    end
  end

  describe "unique_block_id?" do
    it "returns false if reservation_id is not unique" do
      first =  @ritz.make_block(@feb1, @feb5, [1,2,3,4], 0.75)
      second = first.dup
      @ritz.unique_block_id?(second).must_equal false
    end

    it "returns true if reservation_id is unique" do
      @ritz.make_block(@feb1, @feb5, [1,2,3,4], 0.75)
      second = My_Hotel::Block.new(@feb6, @may6, [1,2,3,4], 0.75)
      @ritz.unique_block_id?(second).must_equal true
    end
  end

  describe "find_reservations_by_date" do
    it "given a date, it returns an array of reservations on that date" do
      @ritz.make_reservation(@feb1, @feb5)
      @ritz.make_reservation(@feb3, @may6)
      @ritz.make_reservation(@apr3, @apr6)
      feb3_reservations = @ritz.find_reservations_by_date(@feb3)

      feb3_reservations.must_be_kind_of Array
      feb3_reservations.length.must_equal 2
      feb6_reservations = @ritz.find_reservations_by_date(@feb6)
      feb6_reservations.length.must_equal 1
    end

    it "given a date, it returns an empty array if there are no reservations on that date" do
      @ritz.make_reservation(@feb1, @feb5)
      may6_reservations = @ritz.find_reservations_by_date(@may6)
      may6_reservations.must_be_empty
    end
  end

  describe "find_blocks_by_date" do
    it "given a date, it returns an array of reservations on that date" do
      @ritz.make_block(@feb1, @feb5, [1, 2, 3, 4], 0.75)
      @ritz.make_block(@feb3, @may6, [5, 6, 7, 8], 0.75)
      @ritz.make_block(@apr3, @apr6, [1, 2, 3, 4], 0.75)
      feb3_blocks = @ritz.find_blocks_by_date(@feb3)

      feb3_blocks.must_be_kind_of Array
      feb3_blocks.length.must_equal 2

      feb6_blocks = @ritz.find_blocks_by_date(@feb6)
      feb6_blocks.length.must_equal 1
    end

    it "given a date, it returns an empty array if there are no reservations on that date" do
      @ritz.make_block(@feb1, @feb5, [1, 2, 3, 4], 0.75)
      may6_reservations = @ritz.find_blocks_by_date(@may6)
      may6_reservations.must_be_empty
    end
  end


  describe "find_by_reservation_id" do
    it "given a reservation id, it returns that reservation" do
      first = @ritz.make_reservation(@feb1, @feb5)
      second = @ritz.make_reservation(@feb3,@may6)
      first.reservation_id
      @ritz.find_by_reservation_id(first.reservation_id).must_equal first
      @ritz.find_by_reservation_id(second.reservation_id).must_equal second
    end

    it "given a reservation id, it returns nil if that reservation does not exist" do
      @ritz.find_by_reservation_id(5).must_be_nil
    end
  end

  describe "make_block" do
    it "can make a block of rooms with the same block_id" do
      new_block = @ritz.make_block(@feb1, @feb5, [1, 2, 3, 4], 0.75)
      new_block.must_be_kind_of My_Hotel::Block
      new_block.block_id.must_be_kind_of String
    end

    it "raises an argument if the user attempts to make a block with more than 4 rooms" do
      proc{@ritz.make_block(@feb1, @feb5, [1, 2, 3, 4, 5], 0.75)}.must_raise ArgumentError
    end

    it "updates all_blocks" do
      new_block = @ritz.make_block(@feb1, @feb5, [1, 2, 3, 4], 0.75)
      @ritz.all_blocks.length.must_equal 1
      new_block = @ritz.make_block(@feb6, @may6, [1, 2, 3, 4], 0.75)
      @ritz.all_blocks.length.must_equal 2
    end
  end

  describe "find_by_block" do
    it "given a block id, it returns that block" do
      first = @ritz.make_block(@feb1, @feb5,[1,2,3,4], 0.75)
      second = @ritz.make_block(@feb3,@may6,[5,6,7,8], 0.75)
      @ritz.find_by_block_id(first.block_id).must_equal first
      @ritz.find_by_block_id(second.block_id).must_equal second
    end
    #
    it "given a reservation id, it returns nil if that reservation does not exist" do
      @ritz.find_by_block_id(5).must_be_nil
    end
  end


  describe "find_all_unreserved_rooms " do
    it "returns an array" do
      nights = (@feb1 .. @feb5)
      free_rooms = @ritz.find_all_unreserved_rooms(nights)
      free_rooms.must_be_kind_of Array
      free_rooms.length.must_equal 5
      free_rooms[0].must_be_kind_of Hash
      free_rooms[0].length.must_equal 20
    end

    it "works for a one night stay" do
      free_rooms = @ritz.find_all_unreserved_rooms(@feb1)
      free_rooms.must_be_kind_of Array
      free_rooms.length.must_equal 1
    end

    it "returns a hash of the available rooms" do
      19.times do |i|
        @ritz.make_reservation(@feb1, @feb5)
        free_rooms = @ritz.find_all_unreserved_rooms(@feb1..@feb5)
        free_rooms[-1].length.must_equal 19 - i
      end
      @ritz.make_reservation(@feb1, @feb5)
      free_rooms = @ritz.find_all_unreserved_rooms(@feb1..@feb5)
      free_rooms[-1].length.must_equal 0
    end
  end

  describe "find_all_unblocked_rooms " do
    it "returns an array" do
      nights = (@feb1 .. @feb5)
      free_rooms = @ritz.find_all_unblocked_rooms(nights)
      free_rooms.must_be_kind_of Array
      free_rooms.length.must_equal 5
      free_rooms[0].must_be_kind_of Hash
      free_rooms[0].length.must_equal 20
    end

    it "works for a one night block" do
      free_rooms = @ritz.find_all_unblocked_rooms(@feb1)
      free_rooms.must_be_kind_of Array
      free_rooms.length.must_equal 1
    end
    #
    it "returns a hash of the available rooms" do
      free_rooms = @ritz.find_all_unblocked_rooms(@feb1)
      @ritz.make_block(@feb1, @feb5, [1, 2, 3, 4], 0.75)
      free_rooms = @ritz.find_all_unblocked_rooms(@feb1)
      free_rooms = free_rooms[0].length.must_equal 16

      free_rooms = @ritz.find_all_unblocked_rooms(@feb1..@feb5)
      free_rooms[0].length.must_equal 16
      #
      @ritz.make_block(@feb1, @feb3, [5, 6], 0.75)
      free_rooms = @ritz.find_all_unblocked_rooms(@feb1)
      free_rooms = free_rooms[0].length.must_equal 14
      free_rooms = @ritz.find_all_unblocked_rooms(@feb1..@feb5)
      free_rooms[0].length.must_equal 14
      free_rooms = @ritz.find_all_unblocked_rooms(@feb5)
      free_rooms = free_rooms[0].length.must_equal 16

      @ritz.make_reservation(@feb1, @feb5)
      free_rooms = @ritz.find_all_unblocked_rooms(@feb5)
      free_rooms = free_rooms[0].length.must_equal 16
    end
  end

  describe "open_rooms" do
    it "returns an array of hashes representing open rooms for a range of dates" do
      all_available = @ritz.open_rooms(@feb1..@feb5)
      all_available.must_be_kind_of Array
      all_available.length.must_equal 5
      all_available[0].must_be_kind_of Hash
      all_available[0].length.must_equal 20
    end

    it "returns an array of hashes representing open rooms for one date" do
      all_available = @ritz.open_rooms(@feb1)
      all_available.must_be_kind_of Array
      all_available.length.must_equal 1
      all_available[0].must_be_kind_of Hash
      all_available[0].length.must_equal 20
    end

    it "if no rooms are available, returns empty array" do
      20.times do
        @ritz.make_reservation(@feb1, @feb1)
      end
      none_available = @ritz.open_rooms(@feb1)
      none_available[0].length.must_equal 0
    end

    it "if you reserve a room, it is not available" do
      @ritz.make_reservation(@feb1, @feb5)
      one_reserved = @ritz.open_rooms(@feb1..@feb5)
      one_reserved[0].length.must_equal 19
    end
    it "if you make a block, they are not available" do
      @ritz.make_block(@feb1, @feb5, [1, 2, 3, 4], 0.75)
      one_reserved = @ritz.open_rooms(@feb1..@feb5)
      one_reserved[0].length.must_equal 16
    end

    it "if you make a block and a reservation, all those rooms are not available" do
      @ritz.make_block(@feb1, @feb5, [1, 2, 3, 4], 0.75)
      @ritz.make_reservation(@feb1, @feb3)
      reservation_and_block = @ritz.open_rooms(@feb1)
      reservation_and_block[0].length.must_equal 15
      reservation_and_block = @ritz.open_rooms(@feb5)
    end
  end

  describe "find_continious_open_room" do
    it "must return an hash of room =>prices" do
      nights = (@feb1 .. @feb5)
      free_rooms = @ritz.find_continious_open_room(nights)
      free_rooms.must_be_kind_of Hash
      free_rooms.keys.must_equal @ritz.display_rooms
    end

    it "works for a one night stay" do
      free_rooms = @ritz.find_continious_open_room(@feb1)
      free_rooms.must_be_kind_of Hash
      free_rooms.length.must_equal 20
    end

    it "must return available room =>prices" do
      20.times do |i|
        holiday = @ritz.make_reservation(@feb1, @feb5)
        free_rooms = @ritz.find_continious_open_room(@feb1.. @feb5)
        free_rooms.length.must_equal 19 - i
        free_rooms.wont_include holiday.room_number
      end
    end

    it "if no rooms are available, it must return an Error" do
      20.times do |i|
        @ritz.make_reservation(@feb1, @feb5)
      end
      @ritz.find_continious_open_room(@feb1.. @feb5).must_be_empty
    end
  end

  describe "find_rooms_in_block" do
    it "returns an array of rooms in that block" do
      new_block = @ritz.make_block(@feb1, @feb5, [1,2,3,4], 0.75)
      @ritz.find_rooms_in_block(new_block.block_id).must_equal [1,2,3,4]
    end
  end

  describe "find_rooms_in_use_by_block_id" do
    it "returns an empty array if no reservations have been made in an existing block" do
      new_block = @ritz.make_block(@feb1, @feb5, [1,2,3,4], 0.75)
      no_reservation = @ritz.find_rooms_in_use_by_block_id(new_block.block_id)
      no_reservation.must_be_kind_of Array
      no_reservation.must_be_empty
    end

    it "returns an array of rooms that are in use in an existing block" do
      new_block = @ritz.make_block(@feb1, @feb5, [1,2,3,4], 0.75)
      mindy = @ritz.make_reservation_in_block(new_block.block_id)
      reservation_in_block = @ritz.find_rooms_in_use_by_block_id(new_block.block_id)
      puts reservation_in_block
      reservation_in_block.length.must_equal 1
      reservation_in_block[0].must_equal mindy.room_number

      @ritz.make_reservation_in_block(new_block.block_id)
      reservation_in_block = @ritz.find_rooms_in_use_by_block_id(new_block.block_id)
      reservation_in_block.length.must_equal 2
    end

    it "returns an error if block does not exist" do
      proc{@ritz.find_rooms_in_use_by_block_id(0000)}.must_raise ArgumentError
    end

  end


  describe "make_reservation_in_block" do
    it "can make a reservation" do
      new_block = @ritz.make_block(@feb1, @feb5, [1,2,3,4], 0.75)
      mindy = @ritz.make_reservation_in_block(new_block.block_id)
      mindy.block_id.must_equal new_block.block_id
      mindy.cost.must_equal 750
      mindy.room_number.must_be :<, 5
    end
  end



end










#
#
# describe "display_reservations" do
#   it "must put out a list of all the reservations" do
#     #TODO: Test
#   end
# end
#
#
# describe "rooms_available_date" do
#   it "must return a list of availble rooms" do
#     #TODO: Test - List == array?
#     #- List == correct list
#     # rejects bad dates
#   end
# end
#
# describe "rooms_available_block" do
#   it "must return a list of availble rooms in a block" do
#     #TODO: Test - List == array?
#     #- List == correct list
#     # rejects bad dates
#     #rejects bad block ids
#   end
# end
#
# describe "make block" do
#   it "must allow the admin to assign a block_id to rooms" do
#     #TODO: test
#   end
# end
