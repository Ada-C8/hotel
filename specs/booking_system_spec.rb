require_relative 'spec_helper'

describe "BookingSystem" do
  describe "initialize" do
    it "creates an instance" do
      new_reservation =
      Hotel::BookingSystem.new
      new_reservation.must_be_instance_of Hotel::BookingSystem
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

    # it "checks the room availabilty and if the date range overlaps" do
    #   new_reservation = Hotel::BookingSystem.new
    #   start_date = Date.new(2001,02,2)
    #   end_date  = Date.new(2001,02,8)
    #   dates = Hotel::DateRange.new(start_date, end_date)
    #
    #   new_reservation.make_reservation("trey", 2, dates)
    #   # puts new_reservation.collection_of_reservations
    #   checkin_date = Date.new(2001,02,5)
    #   checkout_date = Date.new(2001,02,9)
    #   dates = Hotel::DateRange.new(checkin_date, checkout_date)
    #
    #   new_reservation.room_available(2,dates).must_equal false
    # end
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
