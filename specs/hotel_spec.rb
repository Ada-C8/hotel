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
      holiday = @ritz.make_reservation(@feb1)
      holiday.must_be_kind_of My_Hotel::Reservation
    end

    it "lets you make reservations on the ends of completely booked dates" do
      20.times do
        @ritz.make_reservation(@feb3, @feb5)
      end
      #Completely before
      @ritz.make_reservation(@feb1).must_be_kind_of My_Hotel::Reservation
      #Completely after
      @ritz.make_reservation(@may6).must_be_kind_of My_Hotel::Reservation
      feb2 = Date.civil(2017,2,2)
      #Ends on the checkin date
      @ritz.make_reservation(@feb1, feb2).must_be_kind_of My_Hotel::Reservation
      #Starts on the checkout date
      @ritz.make_reservation(@feb6).must_be_kind_of My_Hotel::Reservation
     end

    it "raises an argument if you try to reserve a room and none is available" do
      #same dates
      20.times do
        @ritz.make_reservation(@feb1, @feb5)
      end
      proc{@ritz.make_reservation(@feb1, @feb5).must_raise ArgumentError}
      #overlaps in the front
      jan27 = Date.civil(2017,1,27)
      proc{@ritz.make_reservation(jan27, @feb3).must_raise ArgumentError}
      #overlaps in the end
      proc{@ritz.make_reservation(@feb3, @apr3).must_raise ArgumentError}
      #completely contained
      proc{@ritz.make_reservation(@feb3).must_raise ArgumentError}
      #completely containing
      proc{@ritz.make_reservation(jan27, @apr3).must_raise ArgumentError}
    end



    it "updates the list_of_reservations" do
      @ritz.make_reservation(@feb1, @feb5)
      @ritz.all_reservations.must_be_kind_of Array
      @ritz.all_reservations.length.must_equal 1
      @ritz.make_reservation(@feb1, @feb3)
      @ritz.all_reservations.length.must_equal 2
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

    it "can make a one-night block" do
      new_block = @ritz.make_block(@feb1, [1, 2, 3, 4], 0.75)
      new_block.must_be_kind_of My_Hotel::Block
    end

    it "updates @all_blocks" do
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

  describe "get_cost" do
    it "returns the cost of a reservation" do
      holiday = @ritz.make_reservation(@feb1, @feb5)
      @ritz.get_cost(holiday).must_equal 1000
    end
  end

  describe "unreserved_and_unblocked" do
    it "returns an array of hashes representing open rooms for a range of dates" do
      all_available = @ritz.unreserved_and_unblocked(@feb1..@feb5)
      all_available.must_be_kind_of Hash
      all_available.length.must_equal 20
    end

    it "returns an array of hashes representing open rooms for one date" do
      all_available = @ritz.unreserved_and_unblocked(@feb1)
      all_available.must_be_kind_of Hash
      all_available.length.must_equal 20
    end

    it "if no rooms are available, returns empty array" do
      20.times do
        @ritz.make_reservation(@feb1, @feb1)
      end
      none_available = @ritz.unreserved_and_unblocked(@feb1)
      none_available.length.must_equal 0
    end

    it "if you reserve a room, it is not available" do
      @ritz.make_reservation(@feb1, @feb5)
      one_reserved = @ritz.unreserved_and_unblocked(@feb1..@feb5)
      one_reserved.length.must_equal 19
    end
    it "if you make a block, they are not available" do
      @ritz.make_block(@feb1, @feb5, [1, 2, 3, 4], 0.75)
      one_reserved = @ritz.unreserved_and_unblocked(@feb1..@feb5)
      one_reserved.length.must_equal 16
    end

    it "if you make a block and a reservation, all those rooms are not available" do
      @ritz.make_block(@feb1, @feb5, [1, 2, 3, 4], 0.75)
      @ritz.make_reservation(@feb1, @feb3)
      reservation_and_block = @ritz.unreserved_and_unblocked(@feb1)
      reservation_and_block.length.must_equal 15
      reservation_and_block = @ritz.unreserved_and_unblocked(@feb5)
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

    it "returns an er
    ror if block does not exist" do
    proc{@ritz.find_rooms_in_use_by_block_id(0000)}.must_raise ArgumentError
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

  describe "check_block_array" do
    it "raises an argument if the user attempts to make a block that includes rooms that are not available" do
      @ritz.make_block(@feb1, @feb5, [1,2,3,4], 0.75)
      proc{@ritz.check_block_array([1, 2, 3, 4], @feb1.. @feb5)}.must_raise ArgumentError
    end
    it "raises an argument if the user attempts to make a block with more than 5 rooms" do
      proc{@ritz.check_block_array([1, 2, 3, 4, 5, 6], @feb1.. @feb5)}.must_raise ArgumentError
    end

    it "does not raise an argument if inputs are OK" do
      @ritz.check_block_array([1, 2, 3, 4], @feb1..@feb5)
    end
  end

  describe "date_range" do
    it "turns a single date into an array" do
      @ritz.date_range(@feb1, @feb1).must_be_kind_of Array
    end

    it "raises an error if the last_night comes before the first_night" do
      proc{@ritz.date_range(@feb5, @feb1)}.must_raise ArgumentError
    end

    it "makes a date range if the the first_night comes before the last_night" do
      @ritz.date_range(@feb1, @feb5).must_be_kind_of Range
    end
  end
end
end
