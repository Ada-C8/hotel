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

    it "should be able to be called on @booking" do
      @booking.must_respond_to :make_reservation
    end #it "should be able to be called on @booking" do

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











    xit "will create a new instance of Reservation" do
      @booking.all_reservations[0].must_be_kind_of Hotel::Reservation
    end # it "will create a new instance of Reservation" do

    xit "will create the right reservation id for each reservation" do
      # TODO
    end # it "will create the right reservation id for each reservation" do

    xit "will create a reservation for one room" do
      # TODO
    end # it "will create a reservation for one room" do

    xit "will create a reservation for two rooms" do
      # TODO
    end # it "will create a reservation for two rooms" do

    xit "will have the correct cost of the reservation" do
      # TODO
    end # it "will have the correct cost of the reservation" do

  end #  describe make_reservation


end # Booking
