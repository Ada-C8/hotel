require_relative 'spec_helper'

describe "BookingSystem" do
  describe "initialize" do
    it "creates an instance" do
      new_reservation =
      Hotel::BookingSystem.new
      new_reservation.must_be_instance_of Hotel::BookingSystem
    end
  end

  describe "room availability" do
    it "checks the room availabilty and if the date range overlaps" do
      new_reservation = Hotel::BookingSystem.new
      checkin_date = Date.new(2001,02,2)
      checkout_date = Date.new(2001,02,10)
      dates = Hotel::DateRange.new(checkin_date, checkout_date)
      puts new_reservation.room_available(1,dates)

    end
  end
#
#     it "creates 20 room objects" do
#       new_reservation =
#       Hotel::BookingSystem.new
#       new_reservation.collection_of_rooms.length.must_equal 20
#     end
#
#     it "checks that collection of rooms is an array" do
#       new_reservation =
#       Hotel::BookingSystem.new
#       new_reservation.collection_of_rooms.must_be_kind_of Array
#     end
#   end
#
#   # describe "create rooms" do
#   #   it "returns the room number" do
#   #     new_reservation =
#   #     Hotel::BookingSystem.new
#   # #     new_reservation.collection_of_rooms[2].must_equal 3
#   # #   end
#   # end
#

end #end of describe block
