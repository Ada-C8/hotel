require_relative 'spec_helper'
require 'date'

describe "Booking" do
  before do
    @booking = Hotel::Booking.new

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
    # before do
    #   @booking.make_reservation()
    # end # before

    it "Should raise an error if inproper dates are given" do
      checkin_day = Date.new(2017, 9, 5)
      checkout_day = Date.new(2017, 9, 7)
      num_of_rooms = 1
      proc{@booking.make_reservation(checkout_day, checkin_day, num_of_rooms)}.must_raise ArgumentError
    end # it "Should raise an error if inproper dates are given" do

    it "should be able to be called on @booking" do
      @booking.must_respond_to :make_reservation
    end #it "should be able to be called on @booking" do

    it "will create a new instance of Reservation" do
      checkin_day = Date.new(2017, 9, 5)
      checkout_day = Date.new(2017, 9, 7)
      num_of_rooms = 1
      @booking.make_reservation(checkin_day, checkout_day, num_of_rooms)
      @booking.all_reservations[0].must_be_kind_of Hotel::Reservation
    end # it "will create a new instance of Reservation" do

    it "should create the correct value for dates_booked" do
      checkin_day = Date.new(2017, 9, 5)
      checkout_day = Date.new(2017, 9, 7)
      num_of_rooms = 1
      @booking.make_reservation(checkin_day, checkout_day, num_of_rooms )[0].date_range.must_equal [checkin_day, (checkin_day + 1)]
    end # it "should create the correct value for date_booked" do

    it "will create the right reservation id for a booking" do
      checkin_day = Date.new(2017, 9, 5)
      checkout_day = Date.new(2017, 9, 7)
      num_of_rooms = 1
      @booking.make_reservation(checkin_day, checkout_day, num_of_rooms )[0].res_id.must_equal 1
    end # it "will create the right reservation_id for a booking" do

    it "will have the right number of rooms in the reservation when asked to book 1 room" do
      checkin_day = Date.new(2017, 9, 5)
      checkout_day = Date.new(2017, 9, 7)
      num_of_rooms = 1
      @booking.make_reservation(checkin_day, checkout_day, num_of_rooms )[0].res_rooms.length.must_equal 1
    end # it "will have the right number of rooms in the reservation when asked to book 1 room" do

    it "will have the right number of rooms in the reservation if three rooms are asked for" do
      checkin_day = Date.new(2017, 9, 5)
      checkout_day = Date.new(2017, 9, 7)
      num_of_rooms = 3
      @booking.make_reservation(checkin_day, checkout_day, num_of_rooms )[0].res_rooms.length.must_equal 3
    end # it "will have the right number of rooms in the reservation if three rooms are asked for" do

    it "will have the right total cost for the reservation" do
      checkin_day = Date.new(2017, 9, 5)
      checkout_day = Date.new(2017, 9, 7)
      num_of_rooms = 3
      @booking.make_reservation(checkin_day, checkout_day, num_of_rooms )[0].total_cost.must_equal 1200 # (2 * 2 * 200.0)
    end # it "will have the right total cost for the reservation" do
  end #  describe make_reservation

  describe "check_date_for_reservations" do
    it "should be able to be called on @booking" do
      @booking.must_respond_to :check_date_for_reservations
    end # it "should be able to be called on @booking" do

    it "should return an empty array is there are no reservations for the date given" do
      #TODO: check for a date range as well in another test
      checkin_day = Date.new(2017, 9, 5)
      checkout_day = Date.new(2017, 9, 7)
      num_of_rooms = 3
      date_to_check = Date.new(2017, 9, 25)
      @booking.make_reservation(checkin_day, checkout_day, num_of_rooms )

      @booking.check_date_for_reservations(date_to_check).must_be_kind_of Array
      @booking.check_date_for_reservations(date_to_check).must_be_empty
    end # it "should return an empty array is there are no reservations for the date given" do

    it "should return an array of all the reservations for the date given" do
      checkin_day = Date.new(2017, 9, 5)
      checkout_day = Date.new(2017, 9, 7)
      num_of_rooms = 1
      date_to_check = Date.new(2017, 9, 6) #both reservations include the 5th of September

      @booking.make_reservation(checkin_day, checkout_day, num_of_rooms )
      @booking.make_reservation(checkin_day, checkout_day, num_of_rooms )
      @booking.check_date_for_reservations(date_to_check).length.must_equal 2
      @booking.check_date_for_reservations(date_to_check)[1].res_id.must_equal 2

    end # it "should return an array of all the reservations for the date given" do

    it "will return an array of all the reservations for a date range" do
      # TODO in wave 2 
    end # it "will return an array of all the reservations for a date range" do
  end # describe "check_date_for_reservations" do

  describe "print_reservations" do
    it "will be an array that is the same length as the result check_date_for_reservations" do
      checkin_day = Date.new(2017, 9, 5)
      checkout_day = Date.new(2017, 9, 7)
      num_of_rooms = 1
      date_to_check = Date.new(2017, 9, 6) #both reservations include the 5th of September

      @booking.make_reservation(checkin_day, checkout_day, num_of_rooms )
      @booking.make_reservation(checkin_day, checkout_day, num_of_rooms )

      check_length = @booking.check_date_for_reservations(date_to_check).length
      @booking.print_reservations(date_to_check).length.must_equal check_length
    end #it "will be an array that is the same length as the result check_date_for_reservations"

    it "will print out in the right format" do
      checkin_day = Date.new(2017, 9, 5)
      checkout_day = Date.new(2017, 9, 7)
      num_of_rooms = 1
      date_to_check = Date.new(2017, 9, 6) #both reservations include the 5th of September

      @booking.make_reservation(checkin_day, checkout_day, num_of_rooms )
      @booking.print_reservations(date_to_check).must_equal [["Reservation ID: 1", "Total cost: $400.0", "Rooms reserved:  1,", "Date range: 2017-09-05 - 2017-09-07"]]
    end # it "will print out in the right format" do

    it "will only include reservations for that date" do
      checkin_day = Date.new(2017, 9, 5) # for first reservation
      checkout_day = Date.new(2017, 9, 7) # for first reservation
      starting = Date.new(2017, 9, 10) # for second reservation
      ending = Date.new(2017, 9, 13) # for second reservation
      num_of_rooms = 2
      date_to_check = Date.new(2017, 9, 6) #both reservations include the 5th of September

      @booking.make_reservation(checkin_day, checkout_day, num_of_rooms ) # will be in print_reservations
      @booking.make_reservation(starting, ending, num_of_rooms ) # won't be in in print_reservations
      @booking.print_reservations(date_to_check).must_equal [["Reservation ID: 1", "Total cost: $800.0", "Rooms reserved:  1, 2,", "Date range: 2017-09-05 - 2017-09-07"]]
    end #it "will only include reservations for that date" do

  #TODO
    # In wave 2 need to test to test that it will work for 2 reservations with differnt rooms in them (will need to have added no duplicate room reservations to make_reservation)

  end # describe "print_reservations" do


end # Booking
