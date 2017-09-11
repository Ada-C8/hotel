#require 'pry'
require_relative 'spec_helper'


describe "Hotel Class" do
  before do
    @hotel = Hotel::Hotel.new
  end #before

  describe "Instantiation" do
    before do
      @test_hotel = Hotel::Hotel.new
    end

    it "can create an instance of the Hotel class" do
      Hotel::Hotel.new.must_be_kind_of Hotel::Hotel
    end #admin class

    it "can create a hash of rooms" do
      @test_hotel.all_rooms.must_be_kind_of Hash
    end #rooms

    it "can return a list of all rooms in the hotel" do
      @test_hotel.must_respond_to :all_rooms
      @test_hotel.all_rooms.length.must_equal 20
    end

  end #Instantiation

  describe "Make Reservations" do
    it "can call Reservation List to create an array to hold reservations" do
      @hotel.reservations.must_be_kind_of Hotel::ReservationList
      @hotel.reservations.reservation_list.must_be_kind_of Array
    end #array

    it "Can create a Reservation Instance for a specified date range:" do
      @hotel.make_reservation(2222, "2012/12/12", "2012/12/15")
      @hotel.reservations.reservation_list[0].must_be_kind_of Hotel::Reservation
    end #call class

    it "Will add a reservation to the Reservation List:" do
      @hotel.make_reservation(2222, "2012/12/12", "2012/12/15")
      @hotel.reservations.reservation_list.length.must_equal 1
    end #call class

    it "Will Raise an error if asked to reserve an unavailable room" do
      @hotel.make_reservation(1000, "2001/1/30", "2001/2/4", room: 1)
      proc {
        @hotel.make_reservation(1000, "2001/1/30", "2001/2/4", room: 1)
      }.must_raise ArgumentError
    end
  end #make reservations

  describe "Raise Errors for Invalid Dates" do
    it "will raise an error when an invalid date (check_in or check_out) range is provided" do
      proc {
        @hotel.make_reservation(1000, "2001/1/32", "2001/2/4", room: 1)
      }.must_raise ArgumentError

      proc {
        @hotel.make_reservation(1000, "2001/1/30", "2001/1/33", room: 1)
      }.must_raise ArgumentError
    end #invalid check in

    it "will raise an error if the Check Out Date is earlier than the Check In date" do
      proc {
        @hotel.make_reservation(1000, "2001/1/10", "2001/1/5", room: 1)
      }.must_raise ArgumentError
    end
  end #invalid dates


  describe "Find Reservations" do
    it "Can find and return a single reservation for a specific date: " do
      @hotel.make_reservation(2222, "2012/12/12", "2012/12/15")
      found = @hotel.find_reservations("2012/12/12", "2012/12/13")
      found[0].view_reservation.must_equal "ID: 2222, Room: 1, Check in: 2012-12-12, Check Out: 2012-12-15, Total Nights: 3, Total Cost: 600"
    end #find a single reservation for a specific date

    it "Can find and return multiple reservations for the same date" do
      @hotel.make_reservation(1203, "2017/12/12", "2017/12/15")
      @hotel.make_reservation(1204, "2017/12/14", "2017/12/16")
      found = @hotel.find_reservations("2017/12/14", "2017/12/15")
      found.length.must_equal 2
      found[0].id.must_equal 1203
      found[1].id.must_equal 1204
    end #multiple reservations

    it "Can return an array of open rooms for a particular date range: " do
      @hotel.make_reservation(2222, "2012/12/12", "2012/12/15")
      @hotel.make_reservation(2224, "2012/12/13", "2012/12/17")
      @hotel.open_rooms("2012/12/12", "2012/12/13").must_be_kind_of Array
      @hotel.open_rooms("2012/12/12", "2012/12/13")[0].must_equal 3
    end #open rooms
  end #find reservations

  describe "Total Cost" do
    it "Given an ID number it can find the Total Cost of a reservation: " do
      @hotel.make_reservation(2222, "2012/12/12", "2012/12/15")
      @hotel.total_cost(2222).must_equal 600
    end #ID Number

    it "Returns 'Reservation Not Found' if it can't find the ID number: " do
      @hotel.make_reservation(2222, "2012/12/12", "2012/12/15")
      @hotel.total_cost(2223).must_equal "Reservation Not Found"
    end #Not Found
  end #Total Cost

  describe "Blocks" do

    it "Can call Block to create an array to store block information" do
      @hotel.block.must_be_kind_of Hotel::Block
      @hotel.block.block_list.must_be_kind_of Array
    end #access class

    it "Will not create a block of more than five rooms" do
      @hotel.create_block(1545, "2017/12/12", "2017/12/15", discount: 50, number_of_rooms: 7, block_name: "WEDDING").must_equal "A block cannot have more than 5 rooms"
    end

    it "Can create a block of available rooms for the requested date range: " do
      @hotel.create_block(1545, "2017/12/12", "2017/12/15", discount: 50, number_of_rooms: 5, block_name: "WEDDING")
      @hotel.block.block_list.length.must_equal 5
    end

    it "Will not allow general reservations for rooms that are in the block: " do
      @hotel.create_block(1545, "2017/12/12", "2017/12/15", discount: 50, number_of_rooms: 5, block_name: "WEDDING")
      proc {
        @hotel.make_reservation(1000, "2017/12/12", "2017/12/15", room: 1)
      }.must_raise ArgumentError
    end

    it "Will not permit a block to contain rooms already assigned to another block " do
      @hotel.create_block(1212, "2017/12/12", "2017/12/15", discount: 50, number_of_rooms: 5, block_name: "WEDDING")
      @hotel.create_block(1214, "2017/12/12", "2017/12/15", discount: 50, number_of_rooms: 5, block_name: "PROM")
      @hotel.create_block(1216, "2017/12/12", "2017/12/15", discount: 50, number_of_rooms: 5, block_name: "CONVENTION")
      @hotel.create_block(1218, "2017/12/12", "2017/12/15", discount: 50, number_of_rooms: 5, block_name: "SCRABBLE TOURNAMENT")
      proc {
        @hotel.create_block(1218, "2017/12/12", "2017/12/15", discount: 50, number_of_rooms: 5, block_name: "DISCO PARTY")
      }.must_raise ArgumentError
    end

    it "Can check whether there are rooms remaining with a specific block " do
      @hotel.create_block(1212, "2017/12/12", "2017/12/15", discount: 50, number_of_rooms: 2, block_name: "WEDDING")
      @hotel.reserve_in_block("WEDDING")
      @hotel.block_open_rooms?("HELD").must_equal true
      @hotel.reserve_in_block("WEDDING")
      @hotel.block_open_rooms?("HELD").must_equal nil
    end

    it "Can reserve a room from the block " do
      @hotel.create_block(1212, "2017/12/12", "2017/12/15", discount: 50, number_of_rooms: 5, block_name: "WEDDING")
      @hotel.reserve_in_block("WEDDING")
      @hotel.reservations.reservation_list.length.must_equal 1
      @hotel.block.block_list.length.must_equal 4
      @hotel.reservations.reservation_list[0].id.must_equal 1212
    end

    it "Can apply discounted room rate " do
      @hotel.create_block(1212, "2017/12/12", "2017/12/15", discount: 50, number_of_rooms: 5, block_name: "WEDDING")
      @hotel.reserve_in_block("WEDDING")
      @hotel.total_cost(1212).must_equal 450
    end

  end #blocks

end #Hotel admin
