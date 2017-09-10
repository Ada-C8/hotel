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
      end

      it "cannot take more than 20 reservations" do
        20.times do
          @hotel1.make_booking(@checkin, @checkout, 1)
        end
        proc do
          @hotel1.make_booking(@checkin, @checkout, 1)
        end.must_raise RoomAvailabilityError
      end

      it "can calculate cost of reservation" do
        try_here = @hotel1.make_booking(@checkin, @checkout, 1)
        try_here.total_cost.must_equal 400
      end

      it "can calculate cost of multiple rooms booked in a reservation" do
        try_again = @hotel1.make_booking(@checkin, @checkout, 2)
        try_again.total_cost.must_equal 800
      end


      it "can take exactly 20 bookings for a particular night and it's one reservation" do
        hotel2= Hotel::Reservations.new
        checkin2 = Date.new(2017,10,5)
        checkout2 = Date.new(2017,10,7)
        hotel2.make_booking(checkin2, checkout2, 20)
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

              hotel3.check_reservations(checkin3, checkout3).length.must_equal 8
            end
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

      it "will raise an error if try to block more than 5 rooms" do
        checkin = Date.new(2018,9,1)
        checkout = Date.new(2018,9,7)
        hotel6 = Hotel::Reservations.new
        proc do
          hotel6.make_block(checkin, checkout, 6, "wedding")
        end.must_raise BlockAvailabilityError

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
          checkout8 = Date.new(2018,7,3)
          hotel8 = Hotel::Reservations.new
          hotel8.make_block(checkin8, checkout8, 1, "wedding")
          h = hotel8.reserve_room_from_block("wedding")
          h.must_be_kind_of Hotel::Block
          h.block_total_cost.must_equal 320
        end
        it "will know if the block is booked" do
          checkin8 = Date.new(2018,6,1)
          checkout8 = Date.new(2018,6,3)
          hotel8 = Hotel::Reservations.new
          hotel8.make_block(checkin8, checkout8, 3, "bachelorette")
          3.times do
            hotel8.reserve_room_from_block("bachelorette")
          end
          # binding.pry
          # proc do
          #   hotel8.reserve_room_from_block("bachelorette")
          # end.must_raise BlockAvailabilityError
        end
      end
    end
  end
end
