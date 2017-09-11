#hotel_spec.rb
require_relative 'spec_helper.rb'
require 'date'
require 'pry'
describe "The Hotel class" do

  before do
    @myhotel = Hotel_Chain::MyHotel.new
  end

  describe "Initializing the Hotel" do

    it "can be initialized" do
      @myhotel.class.must_be_kind_of Class
    end

    it "The hotel can be initialized with a set number of room objects" do
      @myhotel.array_of_rooms.length.must_equal 20
    end

    it "Returns an array" do
      @myhotel.array_of_rooms.must_be_kind_of Array
    end

    it "Hotel object contains an array of room objects" do
      @myhotel.array_of_rooms[0].must_be_instance_of Hotel_Chain::Room
    end

  end # end describe

  describe "list_of_rooms method" do

    it "Prints a statement to the user" do
      proc {@myhotel.list_rooms}.wont_be_nil
    end

    it "Returns an array with length 20" do
      @myhotel.list_rooms.length.must_equal 20

    end

    it "gives expected statement at 0 position" do
      @myhotel.list_rooms[0].must_equal "1. Room 1 - $200/night"
    end
  end #end describe list of rooms method

  describe "it stores reservation objects" do

    it "it stores a reservation and returns the array length" do
    #every time a new reservation is created in the reservation class, it calls the store_reservation method and stores that reservation object"
      @myhotel.store_reservation("8/13/17", "8/16/17")
      @myhotel.store_reservation("9/25/17", "9/29/17")
      @myhotel.reservations_array.length.must_equal 2
    end

  end


  describe "find_reservations_by_date method" do
    #you can input a specific date
    #it returns any reservations which occur on a specific date
    #it iterates through all reservation object

    it "returns an array" do
    @myhotel.store_reservation("8/13/17", "8/16/17")
    @myhotel.store_reservation("9/25/17", "9/29/17")
    @myhotel.find_reservations_by_date("8/14/17").must_be_kind_of Array
    end

    it "it can list all reservations by date - range middle date" do
    @myhotel.store_reservation("8/13/17", "8/16/17")
    @myhotel.store_reservation("9/25/17", "9/29/17")
    @myhotel.find_reservations_by_date("8/14/17").length.must_equal 1
    end

    it "it can list all reservations by date - range start date" do
    @myhotel.store_reservation("8/13/17", "8/16/17")
    @myhotel.store_reservation("9/25/17", "9/29/17")
    @myhotel.find_reservations_by_date("9/25/17").length.must_equal 1
    end

    it "it returns an empty array for searches on the reservation's end date" do
    @myhotel.store_reservation("8/13/17", "8/16/17")
    @myhotel.store_reservation("9/25/17", "9/29/17")
    @myhotel.find_reservations_by_date("8/16/17").length.must_equal 0
    end

    it "it returns an empty array for searches outside the range of any reservations" do
    @myhotel.store_reservation("8/13/17", "8/16/17")
    @myhotel.find_reservations_by_date("8/12/17").length.must_equal 0
    end

  end

  describe "print_reservations_by_date method" do

    it "prints a formatted list of reservations for a particular date" do
      @myhotel.store_reservation("8/13/17", "8/16/17")
      @myhotel.store_reservation("9/25/17", "9/29/17")
      @myhotel.store_reservation("8/15/17", "8/30/17")
      @myhotel.find_reservations_by_date("8/15/17").length.must_equal 2
      @myhotel.print_reservations_by_date("8/15/17").length.must_equal 2
    end

  end

  describe "find_rooms_available method" do

    it "takes in a start date and end date and returns an array of rooms available" do
      @myhotel.store_reservation("8/13/17", "8/16/17")
      @myhotel.store_reservation("9/25/17", "9/29/17")
      @myhotel.store_reservation("8/15/17", "8/30/17")
      @myhotel.store_reservation("8/10/17", "8/13/17")
      @myhotel.store_reservation("8/09/17", "8/14/17")
      @myhotel.find_rooms_available("8/11/17", "8/12/17").must_be_kind_of Array
    end

    it "returns an array of room objects" do
      @myhotel.store_reservation("8/13/17", "8/16/17")
      @myhotel.find_rooms_available("8/11/17", "8/12/17")[0].must_be_instance_of Hotel_Chain::Room
    end

    it "returns an array of 20 objects when searching for a date range that does not overlap with existing reservations" do
      @myhotel.store_reservation("8/13/17", "8/16/17")
      @myhotel.store_reservation("9/25/17", "9/29/17")
      @myhotel.store_reservation("8/15/17", "8/30/17")
      @myhotel.find_rooms_available("8/11/17", "8/12/17").length.must_equal 20
    end

    it "returns an array of 20 objects when searching for a date range that overlaps with the last day of an existing reservations" do
      @myhotel.store_reservation("8/9/17", "8/11/17")
      @myhotel.find_rooms_available("8/11/17", "8/12/17").length.must_equal 20
    end

    it "returns an array of 20 objects when searching for a date range that overlaps with the first day of an existing reservations" do
      @myhotel.store_reservation("8/9/17", "8/11/17")
      @myhotel.find_rooms_available("8/5/17", "8/9/17").length.must_equal 20
    end

    it "returns an array of 19 objects when searching for a date range that overlaps with 1 existing reservations" do
      @myhotel.store_reservation("8/9/17", "8/11/17")
      @myhotel.find_rooms_available("8/8/17", "8/10/17").length.must_equal 19
    end

    it "returns an array of 18 objects when searching for a date range that overlaps with 2 existing reservations" do
      @myhotel.store_reservation("8/9/17", "8/11/17")
      @myhotel.store_reservation("8/10/17", "8/14/17")
      @myhotel.find_rooms_available("8/8/17", "8/15/17").length.must_equal 18
    end

    it "returns an array of 15 objects when searching for a date range that overlaps with 5 overlapping existing reservations" do
      @myhotel.store_reservation("8/13/17", "8/15/17")
      @myhotel.store_reservation("8/13/17", "8/15/17")
      @myhotel.store_reservation("8/13/17", "8/15/17")
      @myhotel.store_reservation("8/13/17", "8/14/17")
      @myhotel.store_reservation("8/13/17", "8/16/17")
      @myhotel.find_rooms_available("8/13/17", "8/15/17").length.must_equal 15
    end

  end #end of describe "find_rooms_available method"

  describe "make a reservation for date range for an available room" do

    it "adds a reservation to the @reservations_array" do
      @myhotel.store_reservation("8/9/17", "8/11/17")
      @myhotel.reservations_array.length.must_equal 1
      @myhotel.store_reservation("8/13/17", "8/14/17")
      @myhotel.reservations_array.length.must_equal 2
    end

    it "it books room 1 if the only reservation ends on the requested reservation start date" do
      @myhotel.store_reservation("8/13/17", "8/15/17")
      @myhotel.store_reservation("8/15/17", "8/15/17")
      #@myhotel.reservations_array[0].room.room_id.must_equal 1
      @myhotel.reservations_array[1].room.room_id.must_equal 1
    end

    it "adds reservations for different available rooms for overlapping reservation dates" do
      @myhotel.store_reservation("8/13/17", "8/15/17")
      @myhotel.store_reservation("8/13/17", "8/15/17")
      @myhotel.reservations_array[1].room.room_id
      @myhotel.reservations_array[1].room.room_id.must_equal 2
      @myhotel.store_reservation("8/13/17", "8/15/17")
      @myhotel.reservations_array[2].room.room_id.must_equal 3
      @myhotel.store_reservation("8/13/17", "8/14/17")
      @myhotel.reservations_array[3].room.room_id.must_equal 4
      @myhotel.store_reservation("8/13/17", "8/17/17")
      @myhotel.reservations_array[4].room.room_id.must_equal 5
    end

  end # end of describe

  describe "Error handling for trying to reserve an unavailable room" do

    it "gives an error if the room is not available" do
      20.times do
        @myhotel.store_reservation("8/13/17", "8/15/17")
      end
      proc {@myhotel.store_reservation("8/13/17", "8/15/17")}.must_raise ReservationNotAvailableError

    end

  end #end of describe

  describe "Reserve_block method" do
    it "Returns an instance of the Block class" do
      newblock= @myhotel.reserve_block("Mary Smith", "9/25/17", "9/29/17", 4, 150)
      newblock.must_be_instance_of Hotel_Chain::Block

    end

    it "returns a block with a reservations array with the correct number of reservations" do
      block = @myhotel.reserve_block("Mary Smith", "9/25/17", "9/29/17", 4, 150)
      block.reservations_array.length.must_equal 4
    end

    it "returns the correct cost for the reservation made inside a block" do
      block = @myhotel.reserve_block("Mary Smith", "9/25/17", "9/29/17", 4, 150)
      block.reservations_array
    end

    it "blocks_array" do
      newblock= @myhotel.reserve_block("Mary Smith", "9/25/17", "9/29/17", 4, 150)
      @myhotel.blocks_array.must_be_kind_of Array
      @myhotel.blocks_array[0].must_equal newblock
    end

    it "only allows a maximum of 5 rooms to be reserved in a block" do
      proc {@myhotel.reserve_block("Harvey Hello", "11/2/17", "11/4/17", 6, 150)}.must_raise ExceededRoomLimitForBlocksError
    end

  end #end describe

  describe "find_unassigned_block_reservations method" do

    before do
      @myhotel.reserve_block("John Smith", "10/25/17", "10/29/17", 5, 175)
      @myhotel.reserve_block("Harriet McDuck", "11/12/17", "11/14/17", 3, 150)
    end

    it "returns an array" do
      @myhotel.find_unassigned_block_reservations("John Smith").must_be_kind_of Array
    end

    it "returns an array of reservation objects" do
      @myhotel.find_unassigned_block_reservations("John Smith")[0].must_be_instance_of Hotel_Chain::Reservation
    end

    it "returns an array of reservation objects which have a status of unassigned" do
      5.times do |x|
        @myhotel.find_unassigned_block_reservations("John Smith")[x].status.must_equal "unassigned"
      end
    end

    it "returns an error if there are no block reservations found by a given party name" do
      proc {@myhotel.find_unassigned_block_reservations("Nancy Smith")}.must_raise NoPartyByThatNameError
    end

  end #end describe

  describe "assign a room within a block of rooms - assign_block_reservation method" do

    it "returns a reservation object" do
      @myhotel.reserve_block("John Smith", "10/25/17", "10/29/17", 5, 175)
      @myhotel.assign_block_reservation("John Smith").must_be_instance_of Hotel_Chain::Reservation
    end

    it "returns a reservation object with the status changed to assigned" do
      @myhotel.reserve_block("Mary Smith", "9/25/17", "9/29/17", 4, 150)
      @myhotel.find_unassigned_block_reservations("Mary Smith")[0].status.must_equal "unassigned"
      @myhotel.assign_block_reservation("Mary Smith")
      marysmith = @myhotel.blocks_array[0]
      marysmith.reservations_array[0].status.must_equal "assigned"
        x = 1
        3.times do
          marysmith.reservations_array[x].status.must_equal "unassigned"
        end
    end

    it "if 3 of 4 reservations in a block are assigned, the find_unassigned_block_reservations method returns only 1 reservation" do
      @myhotel.reserve_block("Mary Smith", "9/25/17", "9/29/17", 4, 150)
      3.times do
        @myhotel.assign_block_reservation("Mary Smith")
      end
      @myhotel.find_unassigned_block_reservations("Mary Smith").length.must_equal 1
    end


    it "returns an error if there are no unassigned rooms for a given block" do
      @myhotel.reserve_block("John Smith", "10/25/17", "10/29/17", 4, 175)
      4.times do
        @myhotel.assign_block_reservation("John Smith")
      end
      proc {@myhotel.find_unassigned_block_reservations("John Smith")}.must_raise AllBlockRoomsAssignedError
    end

  end #end describe

  describe "match_block_partyname method" do

    it "prints and returns an array the names of all blocks party names that may be a match" do
      @myhotel.reserve_block("John Smith", "10/25/17", "10/29/17", 4, 175)
      @myhotel.reserve_block("Mary Smith", "9/25/17", "9/29/17", 4, 150)
      @myhotel.reserve_block("Smithy Dickens", "11/12/17", "11/14/17", 3, 150)
      @myhotel.reserve_block("Harriet McDuck", "11/12/17", "11/14/17", 3, 150)
      @myhotel.reserve_block("McDuck Wedding", "12/5/17", "12/7/17", 5, 150)
      @myhotel.match_block_partyname("McDuck").length.must_equal 2
      @myhotel.match_block_partyname("Smith").length.must_equal 3
      @myhotel.match_block_partyname("smith").length.must_equal 3
      @myhotel.match_block_partyname("wedding").length.must_equal 1
    end
  end

  describe "Allow a user to set different rates for different rooms" do
    it "makes a reservation and sets a custom date" do
      new_reservation = @myhotel.create_custom_rate("11/12/17", "11/14/17", 160)
      new_reservation.room.rate.must_equal 160
    end
  end

end #end of testing
