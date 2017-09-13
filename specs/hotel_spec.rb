require_relative 'spec_helper'

describe "Administration#Hotel" do

  describe "instantiate hotel" do
    it "return all rooms" do
      rooms = 12
      hotel = Administration::Hotel.new(rooms)
      hotel.all_rooms.length.must_equal 12
      hotel.all_rooms.must_be_kind_of Array
    end

    it "return a given room" do
      rooms = 12
      hotel = Administration::Hotel.new(rooms)
      hotel.all_rooms[0].must_equal 1
      hotel.all_rooms[4].must_equal 5
      hotel.all_rooms.first.must_equal 1
      hotel.all_rooms.last.must_equal 12
    end
  end

  # describe "#all_reservations" do
  #   it "return an array of all the reservations for the hotel" do
  #     check_in = Date.new(2017, 9, 1)
  #     check_out = Date.new(2017, 9, 5)
  #     reservation = Administration::Reservation.new(check_in, check_out)
  #     reservation.all_reservations.must_be_instance_of Array
  #   end
  # end

  describe "#all_reservations" do
    it "return an array of all the reservations for the hotel" do
      rooms = []
      hotel = Administration::Hotel.new(rooms)
      hotel.all_reservations.must_be_instance_of Array
    end
  end
#
#   describe "#listing_rooms" do
#     it "return an array of all rooms" do
#       rooms = 12
#       room_list = Administration::Hotel.new(rooms)
#       room_list.listing_rooms[0].must_equal 1
#       room_list.listing_rooms[4].must_equal 5
#       room_list.listing_rooms.first.must_equal 1
#       room_list.listing_rooms.last.must_equal 12
#     end
#   end
#
#   # describe "#book_reservation" do
#   #   it "return a hash of reservations" do
#   #     rooms = 12
#   #     room_list = Administration::Hotel.new(rooms)
#   #     room_list.book_reservation.must_be_kind_of Hash
#   #   end
#   # end


end #end of hotel
