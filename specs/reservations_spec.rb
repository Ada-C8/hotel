require_relative 'spec_helper'
require 'pry'

describe "Hotel" do
  describe "Reservations" do

    before do
      #fake reservations to run tests
      @hotel1 = Hotel::Reservations.new
      @checkin = Date.new(2017,9,5)
      @checkout = Date.new(2017,9,7)
    end

    it "will create a reservation" do
      res = @hotel1.make_booking(@checkin, @checkout, 1)
      res.must_be_instance_of Hotel::Booking
    end

    it "cannot take more than 20 reservations" do
      20.times do
        @hotel1.make_booking(@checkin, @checkout, 1)
      end
      proc do
        @hotel1.make_booking(@checkin, @checkout, 1)
      end.must_raise ArgumentError
    end

    it "can take exactly 20 reservations for a particular night" do
      hotel2= Hotel::Reservations.new
      checkin = Date.new(2017,9,5)
      checkout = Date.new(2017,9,7)
      hotel2.make_booking(checkin, checkout, 20)
        #  binding.pry
        # wednesday night: doesn't work. wants reservations to equal 40
      hotel2.check_reservations(checkin, checkout).length.must_equal 20

    end

    it "stores an array of rooms" do
      @hotel1.all_rooms.must_be_kind_of Array
      @hotel1.all_rooms.length.must_equal 20
    end
    #book 20 rooms and then try to make one more
    #book 20 rooms for one night and 20 rooms for different night
    # can list the current reservations
    # delete reservation

  end
end

# @dates = Hotel::DateRange.new(@checkin, @checkout)
# date_range = Hotel::DateRange.new(@checkin, @checkout)
#
# room = @hotel1.all_rooms[0]
# @res1 = Hotel::Booking.new(@checkin, @checkout, [room], 1)
# @hotel1.all_reservations << @res1
# @res1 = @hotel1.mak
# @res2 = @hotel1.make_booking(@checkin, @checkout, 1 )
# implicitly shoveled @hote1.all_reservations << @res2

#   @res1 = Hotel::Booking.new(checkin, checkout, [Hotel::Room.arr_rooms[1]], 1)
#   @res2 = Hotel::Booking.new(checkin, checkout, [Hotel::Room.arr_rooms[2]], 2)
#   @res3 = Hotel::Booking.new(checkin, checkout, [Hotel::Room.arr_rooms[3]], 3)
#   @hotel1.all_reservations = [@res1, @res2, @res3]
# end
# before do
#    @hotel_res = Hotel::Reservations.new
#
#    @start_date = Date.new(2017,9,1)
#    @end_date = Date.new(2017,9,3)
#    date_range = Hotel::DateRange.new(@start_date, @end_date)

#    room = @hotel_res.all_rooms[0]
#    booking1 = Hotel::Booking.new(1, [room], date_range)
#         (id, rooms, date_range)
#    @hotel_res.all_reservations << booking1
#
#    @booking2 = @hotel_res.make_booking(1, @start_date, @end_date)
#  end

# errors that that admin could mess up:
# THIS FAILS:
# it "is and instance of Reservations" do
#   @hotel1.must_be_instance_of Hotel::Reservations
# end

# it "before a reservation can be made, it checks availablity" do
# end

# it "must check if date range is available" do
#   res1.check_reservation
# end

# it "if we have availability, it creates a reservation" do
#
# end
#
# it "all_reservations is an array of all reservations" do
#
# end
#
#
# it "reservation is pushed into all_reservations array" do
#
# end
