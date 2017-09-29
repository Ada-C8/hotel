require_relative './spec_helper'
require_relative '../lib/hotel'
require 'pry'
#
describe "#HOTEL" do
  before do
    @my_hotel = Hotel.new
    @reservation1 = {check_in: "January 4, 2018", check_out: "January 10, 2018", room: [@my_hotel.rooms[0]]}
    @reservation2 = {check_in: "January 5, 2018", check_out: "January 10, 2018", room: [@my_hotel.rooms[1]]}
    @reservation3 = {check_in: "January 8, 2018", check_out: "January 14, 2018", room: [@my_hotel.rooms[2]]}

    @my_hotel.make_reservation(@reservation1[:check_in], @reservation1[:check_out], @reservation1[:room])
    @my_hotel.make_reservation(@reservation2[:check_in], @reservation2[:check_out], @reservation2[:room])
    @my_hotel.make_reservation(@reservation3[:check_in], @reservation3[:check_out], @reservation3[:room])
  end
#
  describe "#INITIALIZE" do
    it "Hotel Can initialize with 20 rooms" do
      @my_hotel.must_be_instance_of Hotel
      @my_hotel.rooms.length.must_equal 20
    end

    it "A list of ALL rooms can be displayed/accessed by the admin" do
      @my_hotel.rooms.must_be_instance_of Array
      @my_hotel.rooms.first.must_be_instance_of Room
    end
  end

  describe "#RESERVATIONS" do
    it "Can display a list of reservations" do
      @my_hotel.reservations.must_be_instance_of Array
      @my_hotel.reservations.first.must_be_instance_of Reservation
      @my_hotel.reservations.last.must_be_instance_of Reservation
      @my_hotel.reservations.first.room_numbers.first.must_equal 1
    end

    it "Can reserve rooms that are available" do
      @reservation4 = {check_in: "January 7, 2018", check_out: "January 11, 2018", room: [@my_hotel.rooms[19]]}
      @my_hotel.make_reservation(@reservation4[:check_in], @reservation4[:check_out], @reservation4[:room])
      @my_hotel.reservations.length.must_equal 4
    end


    it "Can book a reservation for a room the same day another reservation ends" do
      @reservation5 = {check_in: "January 10, 2018", check_out: "January 11, 2018", room: [@my_hotel.rooms[0]]}
      @my_hotel.make_reservation(@reservation5[:check_in], @reservation5[:check_out], @reservation5[:room])
      @my_hotel.reservations.length.must_equal 4
    end

    it "Rejects reservation attemps on rooms that are already reserved for the specified dates" do
      @reservation5 = {check_in: "January 7, 2018", check_out: "January 13, 2018", room: [@my_hotel.rooms[1]]}
      proc{@my_hotel.make_reservation(@reservation5[:check_in], @reservation5[:check_out], @reservation5[:room])}.must_raise ArgumentError
      @my_hotel.reservations.length.must_equal 3
    end

    it "Can display a list of reservations for a specific date" do
      @my_hotel.reservation_by_date("January 5, 2018").must_be_instance_of Array
      @my_hotel.reservation_by_date("January 5, 2018").length.must_equal 2
      @my_hotel.reservation_by_date("January 5, 2018").first.must_be_instance_of Reservation
      @my_hotel.reservation_by_date("January 10, 2018").length.must_equal 1
      @my_hotel.reservation_by_date("Janury 9, 2018").length.must_equal 3
      @my_hotel.reservation_by_date("2018-01-25").length.must_equal 0
    end

    it "Can add a reservation (#BLOCK) with more than one room to the reservations list" do
      before_block = @my_hotel.reservations.length

      @block_reserve = {check_in: "January 20, 2018", check_out: "January 25, 2018", rooms: [@my_hotel.rooms[4], @my_hotel.rooms[5], @my_hotel.rooms[6]]}

      @my_hotel.make_reservation(@block_reserve[:check_in], @block_reserve[:check_out], @block_reserve[:rooms])
      before_block.must_equal @my_hotel.reservations.length-1
    end

    it "Will not create a block for which one of the room has a conflicting reservation" do
      #the first room in the block reserve has a conflict described in before/do section
      @block_reserve2 = {check_in: "January 4, 2018", check_out: "January 25, 2018", rooms: [@my_hotel.rooms[0], @my_hotel.rooms[1], @my_hotel.rooms[2]]}

      proc{@my_hotel.make_reservation(@block_reserve2[:check_in], @block_reserve2[:check_out], @block_reserve2[:rooms])}.must_raise ArgumentError
    end

  end

  describe "#ROOMS" do
    it "Can find rooms reserved for a specific date" do
      @my_hotel.rooms_reserved("January 9, 2018", "January 10, 2018").must_be_instance_of Array
      @my_hotel.rooms_reserved("January 9, 2018", "January 10, 2018").length.must_equal 3
      @my_hotel.rooms_reserved("January 9, 2018", "January 10, 2018").first.must_be_instance_of Room
    end

    it "Can find rooms with availability for a given date range" do
      @my_hotel.rooms_available("January 9, 2018", "January 20, 2018").must_be_instance_of Array
      @my_hotel.rooms_available("January 9, 2018", "January 20, 2018").length.must_equal 17
      @my_hotel.rooms_available("January 9, 2018", "January 20, 2018").first.must_be_instance_of Room
      @my_hotel.rooms_available("January 9, 2018", "January 20, 2018").last.must_be_instance_of Room
    end
  end
end

#
#
# #CLI feature
# # it "#show_all_rooms returns a display of all of the available rooms" do
# #   @my_hotel.show_all_rooms.must_be_instance_of Array
# #   @my_hotel.show_all_rooms.length.must_equal 20
# #   @my_hotel.show_all_rooms.first.must_equal "{number: 1, rate: 200}"
# # end
#
# #
# #   xdescribe "check_status" do
# #     it "Returns the status of a room for the given date range" do
# #       #
# #     end
# #   end
# # end
