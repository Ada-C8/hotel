require_relative 'spec_helper'
require 'date'
require 'pry'

describe "Booking" do
  before do
    @booking = Hotel::Booking.new
    @checkin_day = Date.new(2017, 9, 5)
    @checkout_day = Date.new(2017, 9, 7)
    @num_of_rooms = 1
    @start_date_to_check = Date.new(2017, 9, 20) #both reservations include the 5th of September
    @end_date_to_check = Date.new(2017, 9, 25)

  end # before
  describe "initialize" do

    it "will initialize an instance of the Reservation class" do
      @booking.must_be_kind_of Hotel::Booking
    end # it "will initialize an instance of the Reservation class" do

    it "will be initialized with @all_reservations, an empty array" do
      @booking.all_reservations.must_be_kind_of Array
      @booking.all_reservations.must_be_empty
    end # it "will be initialized with @all_reservations, an empty array" do

    it "will initialize 20 instances of Room in an array" do
      @booking.all_rooms.must_be_kind_of Array
      @booking.all_rooms.length.must_equal 20
    end #it "will initialize 20 instances of Room" do

    it "should have each element in the @all_rooms array be an instance of the Room class" do
      @booking.all_rooms.each do |room|
        room.must_be_kind_of Hotel::Room
      end # .each
    end # it "should have each element in the @all_rooms array be an instance of the Room class" do

    it "will have the right room_id for the first room in the @all_rooms array" do
      @booking.all_rooms[0].room_number.must_equal 1
    end # it "will have the right room_id for the first room in the @all_rooms array" do

    it "will have the right room number for the last room in the @all_rooms array" do
      @booking.all_rooms[19].room_number.must_equal 20
    end # it "will have the right room number for the last room in the @all_rooms array" do
  end # describe initialize

  describe "make_reservation" do


    it "Should raise an error if inproper dates are given" do
      proc{@booking.make_reservation(@checkout_day, @checkin_day, @num_of_rooms)}.must_raise BookingError
    end # it "Should raise an error if inproper dates are given" do

    it "should be able to be called on @booking" do
      @booking.must_respond_to :make_reservation
    end #it "should be able to be called on @booking" do

    it "will create a new instance of Reservation" do
      @booking.make_reservation(@checkin_day, @checkout_day, @num_of_rooms)
      @booking.all_reservations[0].must_be_kind_of Hotel::Reservation
    end # it "will create a new instance of Reservation" do

    it "should create the correct value for dates_booked" do
      @booking.make_reservation(@checkin_day, @checkout_day, @num_of_rooms )[0].date_range.must_equal [@checkin_day, (@checkin_day + 1)]
    end # it "should create the correct value for date_booked" do

    it "will create the right reservation id for a booking" do
      @booking.make_reservation(@checkin_day, @checkout_day, @num_of_rooms )[0].res_id.must_equal 1
    end # it "will create the right reservation_id for a booking" do

    it "will have the right number of rooms in the reservation when asked to book 1 room" do
      @booking.make_reservation(@checkin_day, @checkout_day, @num_of_rooms )[0].res_rooms.length.must_equal 1
    end # it "will have the right number of rooms in the reservation when asked to book 1 room" do

    it "will have the right number of rooms in the reservation if three rooms are asked for" do
      num_of_rooms = 3
      @booking.make_reservation(@checkin_day, @checkout_day, num_of_rooms )[0].res_rooms.length.must_equal 3
    end # it "will have the right number of rooms in the reservation if three rooms are asked for" do

    it "will have the right total cost for the reservation" do
      num_of_rooms = 3
      @booking.make_reservation(@checkin_day, @checkout_day, num_of_rooms )[0].total_cost.must_equal 1200 # (2 * 2 * 200.0)
    end # it "will have the right total cost for the reservation" do

    it "should not reserve the same room more than once for a date range" do
      @booking.make_reservation(@checkin_day, @checkout_day, 2) # room 1 and 2
      @booking.make_reservation(@checkin_day, @checkout_day, 2) # room 3 and 4

      availible = @booking.availible_rooms(@checkin_day, @checkout_day)

      availible.must_equal [@booking.all_rooms[4], @booking.all_rooms[5], @booking.all_rooms[6], @booking.all_rooms[7], @booking.all_rooms[8], @booking.all_rooms[9], @booking.all_rooms[10], @booking.all_rooms[11], @booking.all_rooms[12], @booking.all_rooms[13], @booking.all_rooms[14], @booking.all_rooms[15], @booking.all_rooms[16], @booking.all_rooms[17], @booking.all_rooms[18], @booking.all_rooms[19]]
    end # it "should not reserve the same room more than once for a date range" do

    it "will add sequential rooms to the @all_reservation array" do
      @booking.make_reservation(@checkin_day, @checkout_day, 1)
      @booking.make_reservation(@checkin_day, @checkout_day, 1)
      @booking.make_reservation(@checkin_day, @checkout_day, 3)

      # room_array = []

      @booking.all_reservations[0].res_rooms.must_equal [@booking.all_rooms[0]]
      @booking.all_reservations[1].res_rooms.must_equal [@booking.all_rooms[1]]
      @booking.all_reservations[2].res_rooms[0].must_equal @booking.all_rooms[2]
      @booking.all_reservations[2].res_rooms[1].must_equal @booking.all_rooms[3]
      @booking.all_reservations[2].res_rooms[2].must_equal @booking.all_rooms[4]

    end # it "will add sequential rooms to the availe array" do

    it "will never include the same room twice during a given date range" do
      @booking.make_reservation(@checkin_day, @checkout_day, 1)
      @booking.make_reservation(@checkin_day, @checkout_day, 1)
      @booking.make_reservation(@checkin_day, @checkout_day, 3)

      rooms = []
      @booking.check_date_for_reservations(@checkin_day, @checkout_day)
      @booking.check_date_for_reservations(@checkin_day, @checkout_day).each do |res|
        res.res_rooms.each do |room|
          rooms << room
        end #.each
      end # .each

      rooms.length.must_equal 5
      rooms.detect{ |room| rooms.count(room) > 1}.must_equal nil
    end # it "will never include the same room twice during a given date range" do

    it "will raise BookingError if more rooms are asked for then the hotel has (>20)" do
      proc{@booking.make_reservation(@checkin_day, @checkout_day, 21)}.must_raise BookingError
    end # it "will raise BookingError if more than 20 rooms are asked for

    it "will raise BookingError if more rooms are requested then are availible for that date range" do
      @booking.make_reservation(@checkin_day, @checkout_day, 5)
      proc{@booking.make_reservation(@checkin_day, @checkout_day, 18)}.must_raise BookingError
    end # it "will raise BookingError if more rooms are requested then are availible

    it "will be able to book a room the day that it opens up " do
       @booking.make_reservation(@checkin_day, @checkout_day, 20)
      #  @booking.make_reservation(@checkout_day, (@checkout_day + 2), 20).must_be_kind_of Array
       @booking.make_reservation(@checkout_day, (@checkout_day + 2), 20)[0].res_rooms.length.must_equal 20
    end # it "will be able to book a room the day that it opens up " do
  end #  describe make_reservation

  describe "check_date_for_reservations" do
    it "should be able to be called on @booking" do
      @booking.must_respond_to :check_date_for_reservations
    end # it "should be able to be called on @booking" do

    it "should return an empty array is there are no reservations for the date given" do
      num_of_rooms = 3
      @booking.make_reservation(@checkin_day, @checkout_day, num_of_rooms )

      @booking.check_date_for_reservations(@start_date_to_check, @end_date_to_check).must_be_kind_of Array
      @booking.check_date_for_reservations(@start_date_to_check, @end_date_to_check).must_be_empty
    end # it "should return an empty array is there are no reservations for the date given" do

    it "should return an array of all the reservations for the date range given" do
      in_day = Date.new(2017, 9, 5)
      out_day = Date.new(2017, 9, 7)
      num_of_rooms = 1
      start_date_to_check = Date.new(2017, 9, 6) #both reservations include the 5th of September
      end_date_to_check = Date.new(2017, 9, 9)

      @booking.make_reservation(in_day, out_day, num_of_rooms )
      @booking.make_reservation(in_day, out_day, num_of_rooms )
      @booking.check_date_for_reservations(start_date_to_check, end_date_to_check).length.must_equal 2
      @booking.check_date_for_reservations(start_date_to_check, end_date_to_check)[1].res_id.must_equal 2

    end # it "should return an array of all the reservations for the date given" do


  end # describe "check_date_for_reservations" do

  describe "print_reservations" do
    it "will be an array that is the same length as the result check_date_for_reservations" do

      @booking.make_reservation(@checkin_day, @checkout_day, @num_of_rooms )
      @booking.make_reservation(@checkin_day, @checkout_day, @num_of_rooms )

      check_length = @booking.check_date_for_reservations(@start_date_to_check, @end_date_to_check).length
      @booking.print_reservations(@start_date_to_check, @end_date_to_check).length.must_equal check_length
    end #it "will be an array that is the same length as the result check_date_for_reservations"

    it "will print out in the right format" do
      checkin_day = Date.new(2017, 9, 5)
      checkout_day = Date.new(2017, 9, 7)
      num_of_rooms = 1
      start_date_to_check = Date.new(2017, 9, 6) #both reservations include the 5th of September
      end_date_to_check = Date.new(2017, 9, 9)

      @booking.make_reservation(checkin_day, checkout_day, num_of_rooms )
      @booking.print_reservations(start_date_to_check, end_date_to_check).must_equal [["Reservation ID: 1", "Total cost: $400.0", "Rooms reserved:  1,", "Date range: 2017-09-05 - 2017-09-07"]]
    end # it "will print out in the right format" do

    it "will only include reservations for that date" do
      checkin_day = Date.new(2017, 9, 5) # for first reservation
      checkout_day = Date.new(2017, 9, 7) # for first reservation
      starting = Date.new(2017, 9, 10) # for second reservation
      ending = Date.new(2017, 9, 13) # for second reservation
      num_of_rooms = 2
      start_date_to_check = Date.new(2017, 9, 6) #both reservations include the 5th of September
      end_date_to_check = Date.new(2017, 9, 9)

      @booking.make_reservation(checkin_day, checkout_day, num_of_rooms ) # will be in print_reservations
      @booking.make_reservation(starting, ending, num_of_rooms ) # won't be in in print_reservations
      @booking.print_reservations(start_date_to_check, end_date_to_check).must_equal [["Reservation ID: 1", "Total cost: $800.0", "Rooms reserved:  1, 2,", "Date range: 2017-09-05 - 2017-09-07"]]
    end #it "will only include reservations for that date" do
  end # describe "print_reservations" do

  describe "availible_rooms" do
    it "can be called on @booking" do
      @booking.must_respond_to :availible_rooms
    end # it "can be called on @booking" do

    it "will return an array" do
      @booking.availible_rooms(@checkin_day, @checkout_day).must_be_kind_of Array
    end #it "will return an array" do

    it "will include a room that is reserved at a differnt time" do
      room = @booking.make_reservation(@checkin_day, @checkout_day, @num_of_rooms)[0].res_rooms[0]

      @booking.availible_rooms(@start_date_to_check, @end_date_to_check).must_include room
    end # it "will include a room that is reserved at t differnt time" do

    it "must not include a room that alleady has a reservation for that date range" do
      start_date_to_check = Date.new(2017, 9, 6)
      end_date_to_check = Date.new(2017, 9, 9)

      room = @booking.make_reservation(@checkin_day, @checkout_day, @num_of_rooms)[0].res_rooms[0]

      @booking.availible_rooms(start_date_to_check, end_date_to_check).wont_include room
    end # it "must not include a room that alleady has a reservation for that date range" do

    it "will not include a room that is in a block during the given date range" do
      start_date_to_check = Date.new(2017, 9, 6)
      end_date_to_check = Date.new(2017, 9, 9)

      @booking.make_block("Conference", @checkin_day, @checkout_day, 2)

      @booking.availible_rooms(start_date_to_check, end_date_to_check).wont_include @booking.all_rooms[0]
      @booking.availible_rooms(start_date_to_check, end_date_to_check).wont_include @booking.all_rooms[1]
    end # it "will not include a room that is in a block during
  end # describe "availible_rooms" do

  describe "make_block" do
    it "should be able to be called on an instnce of Booking" do
      @booking.must_respond_to :make_block
    end # it "should be able to be called on an instnce of Booking" do

    it "will create a date_range using the date arguments given" do
      @booking.make_block("wedding", @checkin_day, @checkout_day, 1)[0].date_range.must_equal Hotel::DateRange.new(@checkin_day, @checkout_day).nights_booked
    end # it "will create a date_range using the date arguments given" do

    it "Should raise an error if inproper dates are given" do
      proc{@booking.make_block("wedding", @checkout_day, @checkin_day, 1)}.must_raise BookingError
    end # it "Should raise an error if inproper dates are given" do

    it "will raise BookingError if more then five rooms are requested" do
      proc{@booking.make_block("wedding", @checkin_day, @checkout_day, 6)}.must_raise BookingError
    end # raise BookingError for > 5 rooms

    it "will raise a booking error if there are not enough rooms availible to make the block" do
      @booking.make_reservation(@checkin_day, @checkout_day, 10)
      @booking.make_block("Event", @checkin_day, @checkout_day, 5)
      @booking.make_block("Another Event", @checkin_day, @checkout_day, 5)
      proc{@booking.make_block("wedding", @checkin_day, @checkout_day, 4)}.must_raise BookingError
    end # Booking error if not enough availible rooms

    it "will make a new instance of Block" do
      @booking.make_block("wedding", @checkin_day, @checkout_day, 1)
      @booking.all_blocks[0].must_be_kind_of Hotel::Block
    end # it "will make a new instance of Block" do

    it "will have the right @date_range for the block created"do
    @booking.make_block("wedding", @checkin_day, @checkout_day, 1)
    @booking.all_blocks[0].date_range.must_equal [@checkin_day, (@checkin_day + 1)]
  end # it "will have the right @date_range for the block created"do

  it "must have the right @blck_id for the Block created" do
    @booking.make_block("wedding", @checkin_day, @checkout_day, 1)
    @booking.all_blocks[0].block_id.must_equal "WEDDING"
  end # it "must have the right @blck_id for the Block created" do

  it "must have the right rooms in the Block and will add rooms sequentially" do
    @booking.make_block("wedding", @checkin_day, @checkout_day, 3)
    @booking.all_blocks[0].block_rooms.must_equal [@booking.all_rooms[0], @booking.all_rooms[1], @booking.all_rooms[2]]
  end # it "must have the right rooms in the Block" do

  it "will only allow a room to be in one block over a date range" do
    @booking.make_block("wedding", @checkin_day, @checkout_day, 1)
    @booking.make_block("fun event", @checkin_day, @checkout_day, 1)
    @booking.make_block("conference", @checkin_day, @checkout_day, 3)

    rooms = []

    @booking.check_date_for_block(@checkin_day, @checkout_day).each do |block|
      block.block_rooms.each do |room|
        rooms << room
      end # .each
    end # .each

    rooms.length.must_equal 5
    rooms.detect{ |room| rooms.count(room) > 1}.must_equal nil
  end # it "will only allow a room to be in one block over a date range" do

end # describe "make_block" do

  describe "check_date_for_block" do
    it "will be able to be called on @booking" do
      @booking.must_respond_to :check_date_for_block
    end #it "will be able to be called on @booking" do

    it "will return an empty array if not Blocks are in that date range" do
      @booking.make_block("Wedding", @checkin_day, @checkout_day, 5)
      @booking.make_block("another wedding", (@checkin_day + 5), (@checkout_day + 5), 5)

      @booking.check_date_for_block(@start_date_to_check, @end_date_to_check).must_be_empty
    end # it "will return an empty array if not blocks are in that date range" do

    it "will return an array of all the Blocks that are in that date range" do
      start_date_to_check = Date.new(2017, 9, 6)
      end_date_to_check = Date.new(2017, 9, 9)

      @booking.make_block("Wedding", @checkin_day, @checkout_day, 5)
      @booking.make_block("event", (@checkin_day + 2), (@checkout_day + 2), 5)

      @booking.check_date_for_block(start_date_to_check, end_date_to_check).length.must_equal 2
      @booking.check_date_for_block(start_date_to_check, end_date_to_check)[0].block_id.must_equal "WEDDING"
      @booking.check_date_for_block(start_date_to_check, end_date_to_check)[1].block_id.must_equal "EVENT"
    end # it "will return an array of all the Blocks that are in that date range" do

    it "will only allow unique block_ids" do
    @booking.make_block("Wedding", @checkin_day, @checkout_day, 5)

    proc{@booking.make_block("wedding", @checkin_day, @checkout_day, 5)}.must_raise BookingError

    end # it "will only allow unique block_ids" do

  end # describe "check_date_for_block" do

  describe "check_block_availibility" do
      it "will be able to be be called on @booking" do
        @booking.must_respond_to :check_block_availibility
      end # it "will be able to be be called on @booking" do

      it "will return an array of the rooms in the Block with that block_id" do
        @booking.make_block("Wedding", @checkin_day, @checkout_day, 5)

        @booking.check_block_availibility("WEDDING").must_be_kind_of Array
        @booking.check_block_availibility("WEDDING").must_equal @booking.all_blocks[0].block_rooms
      end # will return an array of the rooms in the Block with that block_id"

      it "will raise BookingError if the block_id does not exist" do
        @booking.make_block("Wedding", @checkin_day, @checkout_day, 5)
        proc{@booking.check_block_availibility("another wedding")}.must_raise BookingError
      end # it "will raise BookingError if the block_id does not exist" do
  end # describe "check_block_availibility" do

  describe "rooms_left_in_block" do
      it "will be able to be called on @booking" do
        @booking.must_respond_to :rooms_left_in_block
      end # it "will be able to be called on @booking" do

      it "will raise a BookingError if the ID does not exist" do
        @booking.make_block("Wedding", @checkin_day, @checkout_day, 5)
        proc{@booking.rooms_left_in_block("another wedding")}.must_raise BookingError
      end # it "will raise a BookingError if the ID does not exist" do

      it "will return a string telling you how many rooms are left in the block" do
        @booking.make_block("Wedding", @checkin_day, @checkout_day, 5)
        @booking.rooms_left_in_block("wedding").must_be_kind_of String
        @booking.rooms_left_in_block("wedding").must_equal "There are 5 rooms left in the WEDDING block"
      end # "will return a string telling you how many rooms are left in the block"

      it "will tell you if there are no more rooms left in the bock" do
        @booking.make_block("Wedding", @checkin_day, @checkout_day, 5)
        @booking.reserve_from_block("wedding", 5)
        @booking.rooms_left_in_block("wedding").must_equal "There are no rooms left in the WEDDING block"
      end # it "will tell you if there are no more rooms left in the bock" do
  end #describe "rooms_left_in_block" do

    describe "return_one_block" do
      it "will return the right block" do
        @booking.make_block("Wedding", @checkin_day, @checkout_day, 5)
        @booking.make_block("Event", @checkin_day, @checkout_day, 5)
        @booking.make_block("Birthday", @checkin_day, @checkout_day, 5)

        @booking.return_one_block("wedding").block_id.must_equal "WEDDING"
      end # it "will return the right block" do

      it "will raise argument error id the block doesn't exist" do
        @booking.make_block("Wedding", @checkin_day, @checkout_day, 5)
        proc{@booking.return_one_block("another wedding")}.must_raise BookingError
      end # it "will raise argument error id the block doesn't exist" do
    end # describe "return_one_block" do

    describe "reserve_from_block" do

      it "will be able to be called on @booking" do
        # still in Booking
        @booking.must_respond_to :reserve_from_block
      end # it "will be able to be called on @booking" do

      it "will raise BookingError if the blok ID does not exist" do
        # still in Booking
        proc{@booking.reserve_from_block("random id", 1)}.must_raise BookingError
      end # it "will raise BookingError if the blok ID does not exist" do

      it "will add the room from the block to the @all_reservations list" do
        # in Booking
        @booking.make_block("Wedding", @checkin_day, @checkout_day, 5)
        @booking.all_reservations.length.must_equal 0
        test = @booking.reserve_from_block("wedding", 1)
        @booking.all_reservations.must_equal test
        @booking.all_reservations.length.must_equal 1
      end # it "will add the room from the block to the @all_reservations list" do

      it "will have removed the room reserved from the Blocks @block_rooms" do
        @booking.make_block("Wedding", @checkin_day, @checkout_day, 5)
        @booking.all_blocks[0].block_rooms.length.must_equal 5
        @booking.reserve_from_block("wedding", 1)
        @booking.all_blocks[0].block_rooms.length.must_equal 4
      end # it "will have removed the room reserved from the Blocks @block_rooms" do
    end # describe "reserve_block_room" do

    describe "valid_dates" do
      it "will raise BookingError if checkin and checkout day are the same" do
        proc{@booking.make_reservation(@checkin_day, @checkin_day, 2)}.must_raise BookingError
      end # it "will raise BookingError if checkin and checkout day are the same" do
    end # describe "valid_dates" do
end # Booking
