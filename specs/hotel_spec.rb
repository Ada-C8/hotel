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

  describe "unique_id" do
    it "returns false if reservation_id is not unique" do
      first =  @ritz.make_reservation(@feb1, @feb5)
      second = first.dup
      @ritz.unique_id?(second).must_equal false
    end

    it "returns true if reservation_id is unique" do
      @ritz.make_reservation(@feb1, @feb5)
      second = My_Hotel::Reservation.new(@feb1, @feb5)
      @ritz.unique_id?(second).must_equal true
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
      may6_reservations.must_equal []
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
      new_block = @ritz.make_block(@feb1, @feb5, [1,2,3,4], 0.75)
      new_block.must_be_kind_of My_Hotel::Block
      new_block.block_id.must_be_kind_of String
    end
  end


  # describe "find_by_block" do
  #   it "given a reservation id, it returns that reservation" do
  #     first = @ritz.make_block_reservation(@feb1, @feb5)
  #     second = @ritz.make_block_reservation(@feb3,@may6)
  #     first.reservation_id
  #     @ritz.find_by_block_id(first.block_id).must_equal first
  #     @ritz.find_by_reservation_id(second.block_id).must_equal second
  #   end
  #
  #   it "given a reservation id, it returns nil if that reservation does not exist" do
  #     @ritz.find_by_block_id(5).must_be_nil
  #   end
  # end




  describe "find_all_unreserved_rooms " do
    it "returns an array" do
      nights = (@feb1 .. @feb5)
      free_rooms = @ritz.find_all_unreserved_rooms(nights)
      puts free_rooms[0].class
      free_rooms.must_be_kind_of Array
      free_rooms.length.must_equal 5
      free_rooms[0].must_be_kind_of Hash
      free_rooms[0].length.must_equal 20
    end

    it "returns a hash of the available rooms" do
      # index = 0
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


  describe "find_continious_unreserved_room" do
    it "must return an hash of room =>prices" do
      nights = (@feb1 .. @feb5)
      free_rooms = @ritz.find_continious_unreserved_room(nights)
      free_rooms.must_be_kind_of Hash
      free_rooms.keys.must_equal @ritz.display_rooms
    end

    it "must return available room =>prices" do
      20.times do |i|
        holiday = @ritz.make_reservation(@feb1, @feb5)
        free_rooms = @ritz.find_continious_unreserved_room(@feb1.. @feb5)
        free_rooms.length.must_equal 19 - i
        free_rooms.wont_include holiday.room_number
      end
    end

    it "if no rooms are available, it must return an Error" do
      20.times do |i|
        @ritz.make_reservation(@feb1, @feb5)
      end
      @ritz.find_continious_unreserved_room(@feb1.. @feb5).must_be_empty
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
