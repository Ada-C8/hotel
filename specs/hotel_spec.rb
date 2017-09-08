require_relative 'spec_helper'
describe "Hotel" do
  before do
    @my_hotel = Booking::Hotel.new
  end

  describe "initialize" do
    it "should start with 20 rooms" do
      @my_hotel.list_of_rooms.length.must_equal 20
    end

    it " should have an empty list of reservations" do
      @my_hotel.list_of_reservations.length.must_equal 0
    end

  end

  describe "make reservation method" do

    it " should create a reservation for a given date_range" do
      checkin = Date.new(2017,01,01)
      checkout = Date.new(2017,01,04)
      reserve = @my_hotel.make_reservation(checkin, checkout, 3)

      reserve.date_range.checkin.must_equal checkin
      reserve.date_range.checkout.must_equal checkout

      reserve.room_number.must_equal 3
    end

    it "should add the created reservation to its list" do
      checkin = Date.new(2017,01,01)
      checkout = Date.new(2017,01,04)
      reserve = @my_hotel.make_reservation(checkin, checkout, 3)
      @my_hotel.list_of_reservations.must_include reserve
    end
  end

  describe "list_of_reservations_for_a_date method" do
    before do
      checkin = Date.new(2017,01,01)
      checkout = Date.new(2017,01,04)
      @my_hotel.make_reservation(checkin, checkout, 3)

      checkin = Date.new(2017,01,03)
      checkout = Date.new(2017,01,06)
      @my_hotel.make_reservation(checkin, checkout, 4)

      checkin = Date.new(2017,01,23)
      checkout = Date.new(2017,01,29)
      @reserve = @my_hotel.make_reservation(checkin, checkout, 7)
    end

    it "should returns list of reservations for a specific date" do
      result = @my_hotel.list_of_reservations_for_a_date(Date.new(2017,01,25))

      result.must_be_kind_of Array
      result.length.must_equal 1
      result.must_include @reserve
    end

    it "should return an empty array if no reservations found" do
      result = @my_hotel.list_of_reservations_for_a_date(Date.new(2017, 9, 25))

      result.must_be_kind_of Array
      result.length.must_equal 0
    end
  end

  describe "available_rooms method" do
    it "should return list of rooms that are not reserved for a given date range" do
      checkin = Date.new(2017,01,01)
      checkout = Date.new(2017,01,04)
      @my_hotel.make_reservation(checkin, checkout, 3)

      checkin = Date.new(2017,01,03)
      checkout = Date.new(2017,01,06)
      @my_hotel.make_reservation(checkin, checkout, 4)

      checkin = Date.new(2017,01,04)
      checkout = Date.new(2017,01,12)
      @my_hotel.make_reservation(checkin, checkout, 7)

      checkin = Date.new(2017,01,02)
      checkout = Date.new(2017,01,12)
      available_rooms = @my_hotel.available_rooms(Booking::DateRange.new(checkin,checkout))
      available_rooms.must_equal [1, 2, 5, 6, 8, 9, 10, 11, 12, 13,14,15,16,17,18,19,20 ]
    end

    it "should return an empty array if no available rooms found" do

      checkin = Date.new(2017,01,01)
      checkout = Date.new(2017,01,01)
      @my_hotel.make_reservation(checkin, checkout, room)

      available_rooms = @my_hotel.available_rooms(Booking::DateRange.new(checkin,checkout))
      available_rooms.must_be_kind_of Array
      available_rooms.length.must_equal 0
    end
  end
end
