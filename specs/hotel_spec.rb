require_relative 'spec_helper'

describe "hotel class" do
  describe "instantiation" do

    it "Should be able to instantiate hotel" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.must_be_instance_of HotelManagment::Hotel
    end

    it "Should have rooms array" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.rooms.must_be_instance_of Array
    end

    it "Should have reservations array" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.reservations.must_be_instance_of Array
    end

    it "Should have found_reservations array" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.found_reservations.must_be_instance_of Array
    end

    it "Should be able to add a room" do
      new_room = HotelManagment::Room.new(1)
      new_hotel = HotelManagment::Hotel.new
      new_hotel.rooms << new_room
      new_hotel.rooms.must_equal [new_room]
    end
  end

  describe "add_20_rooms method" do
    it "Hotel should respond to add_20_rooms" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.must_respond_to :add_20_rooms
    end

    it "Rooms array should have 20 rooms inside" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.add_20_rooms
      new_hotel.rooms.length.must_equal 20
    end

    it "Should be able to access list of all available rooms" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.add_20_rooms
      new_hotel.rooms[0].room_number.must_equal 1
      new_hotel.rooms[19].room_number.must_equal 20
    end
  end

  describe "create_reservation" do

    it "Should respond to .create_reservation " do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.must_respond_to :create_reservation
    end

    it "Should have reservations array" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.reservations.must_be_instance_of Array
    end

    it "should be able to add a reservation" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1)
      new_hotel = HotelManagment::Hotel.new
      new_hotel.reservations << new_reservation
      new_hotel.reservations.must_equal [new_reservation]
    end

    it "Should create a reservation with a specific date range" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 2)

      new_reservation.check_in_date.must_equal Date.new(2017,9,5)
      new_reservation.check_out_date.must_equal Date.new(2017,9,10)
    end

    it "Should have a room number" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 2)
      new_reservation.room_number.must_equal 2
    end

    it "Should respond to check_in_date " do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1)
      new_reservation.must_respond_to :check_in_date

    end

    it "Should respond to check_out_date" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1)
      new_reservation.must_respond_to :check_out_date
    end

    it "Should respond to rate method" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1)
      new_reservation.must_respond_to :rate
    end

    it "Should return the cost of a reservation" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1)
      value = new_reservation.rate
      value.must_equal 1000
    end
  end

  describe "reservations_by_date" do

    it "Should return the reservations that overlap with date given" do

      start_date = Date.today

      new_hotel = HotelManagment::Hotel.new
      new_hotel.create_reservation("marisa", "morris", start_date + 5, start_date + 10, 1)
      new_hotel.create_reservation("marisa", "morris", start_date + 11, start_date + 16, 1)
      new_hotel.create_reservation("marisa", "morris", start_date + 20, start_date + 25, 1)

      input = start_date + 5

      new_hotel.reservations_by_date(input).must_equal [new_hotel.reservations[0]]
    end

    it "Raises ArgumentError if dates are Invalid" do
      new_hotel = HotelManagment::Hotel.new

      proc { new_hotel.create_reservation("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,1), 1) }.must_raise ArgumentError
    end

    # TODO this is for the 2ns user story (error handling)
    # it "text" do
    #
    #   start_date = Date.today
    #
    #   new_hotel = HotelManagment::Hotel.new
    #   new_hotel.create_reservation("marisa", "morris", start_date + 5, start_date + 10, 1)
    #
    #   proc { new_hotel.create_reservation("marisa", "morris", start_date + 6, start_date + 8, 1) }.must_raise ArgumentError
    #
    # end
  end

  describe "rooms_not_reserved" do
    it "Should return list of unreserved rooms" do

      start_date = Date.today

      new_hotel = HotelManagment::Hotel.new
      new_hotel.create_reservation("marisa", "morris", start_date + 5, start_date + 10, 1)
      new_hotel.create_reservation("marisa", "morris", start_date + 30, start_date + 35, 2)
      new_hotel.create_reservation("marisa", "morris", start_date + 50, start_date + 55, 3)

      new_hotel.rooms_not_reserved(start_date +5, start_date + 10).must_equal [2,3]

      # new_hotel.rooms_not_reserved(start_date +1, start_date + 2).must_equal [1,2,3]
    end

    it "rooms_not_reserved should be an instance of hotel" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.must_respond_to :rooms_not_reserved
    end

    it "unreserved_rooms must be instance of Array" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.unreserved_rooms.must_be_instance_of Array

    end

  end
end
