require_relative './spec_helper'
require_relative '../lib/hotel'

describe "#HOTEL" do
  before do
    @my_hotel = Hotel.new

    @reservation1 = {check_in: "January 4, 2018", check_out: "January 10, 2018", room: @my_hotel.rooms.first}
    @reservation2 = {check_in: "January 5, 2018", check_out: "January 10, 2018", room: @my_hotel.rooms.first}
    @reservation3 = {check_in: "January 8, 2018", check_out: "January 14, 2018", room: @my_hotel.rooms.first}

    @my_hotel.make_reservation(@reservation1[:check_in], @reservation1[:check_out], @reservation1[:room])

    @my_hotel.make_reservation(@reservation2[:check_in], @reservation2[:check_out], @reservation2[:room])

    @my_hotel.make_reservation(@reservation3[:check_in], @reservation3[:check_out], @reservation3[:room])
  end

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
      @my_hotel.reservations.first.room_number.must_equal 1
    end


    it "Can display a list of reservations for a specific date" do
      @my_hotel.reservation_by_date("January 5, 2018").must_be_instance_of Array
      @my_hotel.reservation_by_date("January 5, 2018").length.must_equal 2
      @my_hotel.reservation_by_date("January 10, 2018").length.must_equal 1
      @my_hotel.reservation_by_date("Janury 9, 2018").length.must_equal 3
      @my_hotel.reservation_by_date("2018-01-25").length.must_equal 0
    end

  end
end
#CLI feature
# it "#show_all_rooms returns a display of all of the available rooms" do
#   @my_hotel.show_all_rooms.must_be_instance_of Array
#   @my_hotel.show_all_rooms.length.must_equal 20
#   @my_hotel.show_all_rooms.first.must_equal "{number: 1, rate: 200}"
# end

#
#   xdescribe "check_status" do
#     it "Returns the status of a room for the given date range" do
#       #
#     end
#   end
# end
