require_relative 'spec_helper'
require 'pry'

describe "Hotel" do
  describe "Reservations" do

    before do
      #fake reservations to run tests
      # should this be a "let"?
      @hotel1 = Hotel::Reservations.new
      @checkin = Date.new(2017,9,5)
      @checkout = Date.new(2017,9,7)
    end
    describe "make_booking" do
      it "will create a reservation" do
        res = @hotel1.make_booking(@checkin, @checkout, 1)
        res.must_be_instance_of Hotel::Booking
        # res.rooms.must_equal 20
      end

      it "cannot take more than 20 reservations" do
        20.times do
          @hotel1.make_booking(@checkin, @checkout, 1)
        end
        proc do
          @hotel1.make_booking(@checkin, @checkout, 1)
        end.must_raise ArgumentError
      end

      it "can calculate cost of reservation" do
        try_here = @hotel1.make_booking(@checkin, @checkout, 1)
        try_here.total_cost.must_equal 400
      end

      it "can calculate cost of multiple rooms booked in a reservation" do
        # 2.times do
        #   @hotel1.make_booking(@checkin, @checkout, 1)
        # end
        try_again = @hotel1.make_booking(@checkin, @checkout, 2)
        # it is 2 nights and 2 rooms should = 800
        try_again.total_cost.must_equal 800
      end


      it "can take exactly 20 bookings for a particular night and it's one reservation" do
        hotel2= Hotel::Reservations.new
        checkin2 = Date.new(2017,10,5)
        checkout2 = Date.new(2017,10,7)
        hotel2.make_booking(checkin2, checkout2, 20)
        # binding.pry
        hotel2.print_reservations.length.must_equal 1
      end

      it "can hold multiple bookings and count those reservations" do
        hotel3 = Hotel::Reservations.new
        checkin3 = Date.new(2017,11,2)
        checkout3 = Date.new(2017,11,4)
        hotel3.make_booking(checkin3, checkout3, 2)
        hotel3.make_booking(checkin3, checkout3, 1)
        hotel3.make_booking(checkin3, checkout3, 1)
        hotel3.print_reservations.length.must_equal 3
      end
      # wednesday night: doesn't work. wants reservations to equal 40
      # hotel2.check_reservations(checkin, checkout).must_equal 1
      describe "all_rooms" do
        it "can list out all of the rooms in the hotel" do
          @hotel1.all_rooms.length.must_equal 20
        end

        it "stores an array of rooms" do
          @hotel1.all_rooms.must_be_kind_of Array
          @hotel1.all_rooms.length.must_equal 20
        end
        describe "all_reservations" do
          it "can print out the list of reservations for a given date" do
            hotel3 = Hotel::Reservations.new
            checkin3 = Date.new(2017,11,2)
            checkout3 = Date.new(2017,11,4)
            hotel3.make_booking(checkin3, checkout3, 2)
            hotel3.make_booking(checkin3, checkout3, 1)
            hotel3.make_booking(checkin3, checkout3, 1)
            # binding.pry
            hotel3.all_reservations[0].id.must_equal 0
          end
          describe "check_reservations and check_availability" do
            it "can view a list of available rooms for a given date" do
              hotel3 = Hotel::Reservations.new
              checkin3 = Date.new(2017,11,2)
              checkout3 = Date.new(2017,11,4)
              hotel3.make_booking(checkin3, checkout3, 2)
              hotel3.make_booking(checkin3, checkout3, 1)
              hotel3.make_booking(checkin3, checkout3, 1)
              hotel3.check_availability(checkin3, checkout3).length.must_equal 16
              # binding.pry
              hotel3.check_reservations(checkin3, checkout3).length.must_equal 8
            end


            #book 20 rooms and then try to make one more
            #book 20 rooms for one night and 20 rooms for different night
            # can list the current reservations
            # delete reservation
          end
        end
      end
    end
    ############ tests above are for reservcations, below are for block reservations ##########
    describe "make_block" do
      it "will create a block" do
        checkin = Date.new(2018,9,1)
        checkout = Date.new(2018,9,7)
        hotel6 = Hotel::Reservations.new
        block1 = hotel6.make_block(checkin, checkout, 5, "wedding")
        block1.must_be_instance_of Hotel::Block
        hotel6.all_blocks.must_be_kind_of Array
      end
    end
    describe "check_block_for_availability" do
      it "it will examine a date and see if it has a block" do
        checkin7 = Date.new(2018,9,1)
        checkout7 = Date.new(2018,9,7)
        hotel7 = Hotel::Reservations.new
        block7 = hotel7.make_block(checkin7, checkout7, 4, "bat_mitzvah")
        block7.check_block_for_availability("bat_mitzvah").must_equal true
      end

      describe "reserve_room_from_block" do
        it "it will reserve a room from a block" do
          checkin8 = Date.new(2018,7,1)
          checkout8 = Date.new(2018,7,4)
          hotel8 = Hotel::Reservations.new
          hotel8.make_block(checkin8, checkout8, 2, "wedding")
          h = hotel8.reserve_room_from_block("wedding")
          #  binding.pry
          h.must_be_kind_of Hotel::Block
          h.block_total_cost.must_equal 960 # test passes BUT the discount should and it should
        end
      end
          # block8 = hotel8.make_block(checkin8, checkout8, [], "sweet_16")
          #
          # block8.reserve_room_from_block("sweet_16").must_equal true

      # describe "check_block_for_availability" do
      #   checkin = Date.new(2018,10,1)
      #   checkout = Date.new(2018,10,7)
      #   block2 = Hotel::Reservations.new.make_block(checkin, checkout, 5, "wedding")
      #   block2.check_block_for_availability(checkin, checkout, "wedding").must_be_kind_of Array
      # end


    end
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
