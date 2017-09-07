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

  describe "make_reservation" do
    it "can make a reservation" do
      @ritz.must_be_kind_of My_Hotel::Hotel
      holiday = @ritz.make_reservation(@feb1, @feb5)
      holiday.must_be_kind_of My_Hotel::Reservation
      #should reject bad dates
    end

    it "calculates the cost" do
      holiday = @ritz.make_reservation(@feb1, @feb5)
      holiday.cost.must_equal 1000 #nominal case
    end

    it "assigns a room number" do
      holiday = @ritz.make_reservation(@feb1, @feb5)
      holiday.room_number.must_be_kind_of Integer
      (1..20).must_include holiday.room_number
    end

    it "updates the list_of_reservations" do
      @ritz.make_reservation(@feb1, @feb5)
      @ritz.all_reservations.must_be_kind_of Array
      @ritz.all_reservations.length.must_equal 1
      @ritz.make_reservation(@feb1, @feb3)
      @ritz.all_reservations.length.must_equal 2
    end
  end
  #
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
      @ritz.find_by_reservation_id(1).must_equal first
      @ritz.find_by_reservation_id(2).must_equal second
    end

    it "given a reservation id, it returns nil if that reservation does not exist" do
      @ritz.find_by_reservation_id(5).must_be_nil
    end
  end

  describe "find unreserved rooms by date" do
    it "returns an hash" do
      nights = (@feb1 .. @feb5)
      free_rooms = @ritz.find_unreserved_rooms(nights)
      free_rooms.must_be_kind_of Hash
      free_rooms.length.must_equal 20
    end

    it "returns a hash of the available rooms" do
      nights = (@feb1 .. @feb5)
      index = 1
      20.times do
        @ritz.make_reservation(@feb1, @feb5)
        free_rooms = @ritz.find_unreserved_rooms(nights)
        free_rooms.length.must_equal 20-index
        index += 1
      end
      @ritz.make_reservation(@feb1, @feb5)
      free_rooms = @ritz.find_unreserved_rooms(nights)
      free_rooms.must_equal nil
    end
  end
  #
  # I think I should split up find_unreserved rooms and
  #reservation so that first the user can see if there are
  #any unreserved rooms for that night.  If so, they can assign one of them by passing it as an argument into make_reservation
  #
  #
  # end
end







# describe "display_rooms"
# it "must puts out a list of all the rooms" do
#   #TODO: Test
# end
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
