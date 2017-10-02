require_relative 'spec_helper'
# can refactor using before or let
describe "BookingSystem" do
  describe "initialize" do
    it "creates an instance" do
      new_reservation =
      Hotel::BookingSystem.new
      new_reservation.must_be_instance_of Hotel::BookingSystem
    end

    it "creates 20 room objects" do
      new_reservation =
      Hotel::BookingSystem.new
      new_reservation.collection_of_rooms.length.must_equal 20

      new_reservation.collection_of_rooms.must_be_kind_of Array
    end
  end

  # describe "With a valid DateRange" do
  #
  #   before do
  #     @checkin_date = Date.new(2001,2,3)
  #     @checkout_date = Date.new(2001,2,14)
  #     @date = Hotel::DateRange.new(@checkin_date, @checkout_date)
  #   end

  describe "room availability" do
    it "checks the room availabilty and if the date range overlaps" do
      new_reservation = Hotel::BookingSystem.new
      start_date = Date.new(2001,02,2)
      end_date  = Date.new(2001,02,8)
      dates = Hotel::DateRange.new(start_date, end_date)

      new_reservation.make_reservation("trey", 2, dates)

      checkin_date = Date.new(2001,02,9)
      checkout_date = Date.new(2001,02,14)
      dates = Hotel::DateRange.new(checkin_date, checkout_date)

      new_reservation.room_available(3,dates).must_equal true
      # @date.date_overlap?(date_range).must_equal true
    end

    it "checks the room availabilty and if the date range overlaps" do
      new_reservation = Hotel::BookingSystem.new
      start_date = Date.new(2001,02,2)
      end_date  = Date.new(2001,02,8)
      dates = Hotel::DateRange.new(start_date, end_date)

      new_reservation.make_reservation("trey", 2, dates)

      checkin_date = Date.new(2001,02,5)
      checkout_date = Date.new(2001,02,9)
      dates = Hotel::DateRange.new(checkin_date, checkout_date)
      # binding.pry
      new_reservation.room_available(2,dates).must_equal false
    end
  end

  describe "make reservation" do
    it "returns a reservation" do
      new_reservation = Hotel::BookingSystem.new
      checkin_date = Date.new(2001,01,01)
      checkout_date = Date.new(2001,01,31)
      dates = Hotel::DateRange.new(checkin_date, checkout_date)
      new_reservation.make_reservation("bob", 1, dates)
      new_reservation.collection_of_reservations.length.must_equal 1
    end

    it "checks that collection_of_reservations is an Array" do
      new_reservation = Hotel::BookingSystem.new
      checkin_date = Date.new(2001,01,02)
      checkout_date = Date.new(2001,01,10)
      dates = Hotel::DateRange.new(checkin_date, checkout_date)
      new_reservation.make_reservation("bob", 1, dates)

      new_reservation = Hotel::BookingSystem.new
      checkin_date = Date.new(2001,01,14)
      checkout_date = Date.new(2001,01,30)
      dates = Hotel::DateRange.new(checkin_date, checkout_date)
      new_reservation.make_reservation("trey", 1, dates)

      new_reservation.collection_of_reservations.must_be_kind_of Array
    end

    it "returns an empty array if no reservations have been made" do
      new_reservation = Hotel::BookingSystem.new
      new_reservation.collection_of_reservations.must_be_empty Array
    end

    # it "raises an error when a room is  unavailabe" do
    #   new_reservation = Hotel::BookingSystem.new
    #   checkin_date = Date.new(2001,01,02)
    #   checkout_date = Date.new(2001,01,10)
    #   dates = Hotel::DateRange.new(checkin_date, checkout_date)
    #   new_reservation.make_reservation("bob", 1, dates)
    #
    #   checkin_date = Date.new(2001,01,5)
    #   checkout_date = Date.new(2001,01,9)
    #   dates = Hotel::DateRange.new(checkin_date, checkout_date)
    #
    #   proc{Hotel::BookingSystem.make_reservation("trey", 1, dates)}.must_raise ArgumentError
    # end
  end

end #end of describe block
