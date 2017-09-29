require 'pry'
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

      date = Date.today

      new_hotel = HotelManagment::Hotel.new
      new_hotel.create_reservation("marisa", "morris", date + 5, date + 10, 1)
      new_hotel.create_reservation("marisa", "morris", date + 11, date + 16, 1)
      new_hotel.create_reservation("marisa", "morris", date + 20, date + 25, 1)

      input = date + 5

      new_hotel.reservations_by_date(input).must_equal [new_hotel.reservations[0]]

    end
  end

  describe "rooms_not_reserved" do

    it "Should respond to rooms_not_reserved" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.must_respond_to :rooms_not_reserved
    end

    it "unreserved_rooms must be instance of Array" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.unreserved_rooms.must_be_instance_of Array
    end

    it "Should return list of unreserved rooms" do
      date = Date.today
      new_hotel = HotelManagment::Hotel.new
      new_hotel.add_20_rooms

      new_hotel.create_reservation("marisa", "morris", date + 5, date + 10, 1)
      new_hotel.create_reservation("marisa", "morris", date + 6, date + 11, 1)
      new_hotel.create_reservation("marisa", "morris", date + 30, date + 35, 2)
      new_hotel.create_reservation("marisa", "morris", date + 50, date + 55, 3)

      new_hotel.rooms_not_reserved(date + 5, date + 10).must_equal [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    end
    # # TODO
    # it "should return list of rooms not in blocks" do
    #
    #   date = Date.today
    #   new_hotel = HotelManagment::Hotel.new
    #   new_hotel.add_20_rooms
    #
    #   new_hotel.create_block(date + 5, date + 10, 5)
    #   new_hotel.rooms_not_reserved(date + 5, date + 10).length.must_equal 15
    #
    # end
  end

  describe "reserve_room_for_date_range" do

    it "Should respond to reserve_room_for_date_range" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.must_respond_to :reserve_room_for_date_range
    end

    it "Should reserve a room for a given date range if no conflicting reservations" do
      date = Date.today
      new_hotel = HotelManagment::Hotel.new
      new_hotel.add_20_rooms

      new_hotel.create_reservation("marisa", "morris", date + 5, date + 10, 1)
      new_hotel.create_reservation("marisa", "morris", date + 30, date + 35, 2)
      new_hotel.create_reservation("marisa", "morris", date + 50, date + 55, 3)

      # puts "test"

      new_hotel.reserve_room_for_date_range("marisa", "morris", date + 36, date + 40)

      new_hotel.reservations.length.must_equal 4
    end


    it "Raises ArgumentError if there are no available rooms" do
      date = Date.today
      new_hotel = HotelManagment::Hotel.new

      proc { new_hotel.reserve_room_for_date_range("marisa", "morris", date + 36, date + 40) }.must_raise ArgumentError
    end
  end

  describe "create_block" do

    it "Should respond to create_block" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.must_respond_to :create_block
    end

    it "Should be able add a new block" do
      date = Date.today
      new_hotel = HotelManagment::Hotel.new
      new_hotel.add_20_rooms
      new_hotel.create_block(date + 1, date + 3, 5)
      new_hotel.blocks.length.must_equal 1
    end

    it "Should be able to add a block considering existing reservations" do
      date = Date.today
      new_hotel = HotelManagment::Hotel.new
      new_hotel.add_20_rooms

      new_hotel.create_block(date + 1, date + 3, 5)
      new_hotel.blocks.length.must_equal 1
    end

    it "Should be able to access a list of all blocks" do
      date = Date.today
      new_hotel = HotelManagment::Hotel.new
      new_hotel.add_20_rooms

      new_hotel.create_block(date + 1, date + 3, 5)
      new_hotel.blocks[0].amount_of_rooms.must_equal 5
    end

    # it "should raise error if block room amount is greater than 5" do
    #   date = Date.today
    #   new_hotel = HotelManagment::Hotel.new
    #
    #   proc {new_hotel.create_block(date + 1, date + 4, 6) }.must_raise ArgumentError
    # end
  end

  describe "reserve_room_in_block" do

    it "Should respond to reserve_room_in_block" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.must_respond_to :reserve_room_in_block
    end


    it "Must be instance of BlockReservation" do
      date = Date.today
      new_hotel = HotelManagment::Hotel.new
      new_hotel.add_20_rooms
      block = new_hotel.create_block(date + 1, date + 2, 5)
      block_reservation = new_hotel.reserve_room_in_block("marisa", "morris", block.id)
      block_reservation.must_be_instance_of HotelManagment::BlockReservation
    end

    it "Should raise argument error if there are no rooms left in the block " do
      date = Date.today
      new_hotel = HotelManagment::Hotel.new
      new_hotel.add_20_rooms
      block = new_hotel.create_block(date + 1, date + 2, 5)
      block.rooms = []

      proc { new_hotel.reserve_room_in_block("marisa", "morris", block.id) }.must_raise ArgumentError

    end

  end

end
