require_relative 'spec_helper'
require_relative '../lib/hotel'


describe "DateRange" do

  describe "initialize" do

    before do
      @start_date = Date.new(2018,1,1)
      @end_date = Date.new(2018,1,3)
      @date = Hotel::DateRange.new(@start_date, @end_date)
    end

    it "checks initialize" do

      @date.must_respond_to :start_date
      @date.start_date.must_be_kind_of Date #edge1
      @date.start_date.must_equal @start_date #edge2

      @date.must_respond_to :end_date
      @date.end_date.must_be_kind_of Date #edge1
      @date.end_date.must_equal @end_date #edge2
    end

    it "checks initialize when start date is after end date" do
      start_date = Date.new(2018,1,1)
      end_date = Date.new(2018,1,3)
      proc {DateRange.new(end_date, start_date)}.must_raise Exception
    end # switching dates instead of later
  end
end #end of date range






describe "Reservation" do
  describe "initialize" do

    before do
      start_date = Date.new(2018,1,1)
      end_date = Date.new(2018,1,4)
      date = Hotel::DateRange.new(start_date, end_date)
      @res = Hotel::Reservation.new(1, date, 200)
    end

    it "checks initialize" do

      @res.must_respond_to :room_number
      @res.room_number.must_be_kind_of Integer
      @res.room_number.must_equal 1

      @res.must_respond_to :cost
      @res.cost.must_be_kind_of Integer
      @res.cost.must_equal 600
    end

  end #end of initialize do

  describe "initialize but checks for same day problems" do

    before do
      start_date = Date.new(2018,1,1)
      end_date = Date.new(2018,1,1)
      date = Hotel::DateRange.new(start_date, end_date)
      @res = Hotel::Reservation.new(1, date, 200)
    end

    it "checks for same day checkin/checkout" do
      @res.cost.must_equal 200
    end

  end #end of initialize same day

end #end of reservation






describe "Room" do
  describe "initialize" do
    before do
      @room = Hotel::Room.new(1)
    end

    it "can initialize rooms" do
      @room.must_be_instance_of Hotel::Room
      @room.must_respond_to :room_number
      @room.room_number.must_be_kind_of Integer
      @room.room_number.must_equal 1
    end
  end
end #end of room class









describe "ReservationSystem" do
  before do
    @hotel = Hotel::ReservationSystem.new()
  end
  describe "initialize" do

    it "checks initialize" do

      @hotel.must_respond_to :rooms
      @hotel.rooms.must_be_kind_of Array
      @hotel.rooms.length.must_equal 20

      @hotel.must_respond_to :room_reservation
      keys = @hotel.room_reservation.keys
      keys.length.must_equal 20

    end #end of it checks initialize
  end #end of describe initialize

  describe "reservations" do

    it "checks room_reservation" do
      start_date = Date.new(2018,1,1)
      end_date = Date.new(2018,1,3)
      date = Hotel::DateRange.new(start_date, end_date)

      @hotel.reservation(1, date)
      @hotel.room_reservation[1].wont_be_nil
    end


    it "checks reservation on existing room" do
      start_date = Date.new(2018,1,1)
      end_date = Date.new(2018,1,3)
      date = Hotel::DateRange.new(start_date, end_date)

      @hotel.reservation(1, date)
      proc {@hotel.reservation(1, date)}.must_raise Exception
    end

    #start of 73.33% coverage --- why isn't it adding more?

    it "checks reservation when start date overlaps" do
      start_date = Date.new(2018,1,1)
      end_date = Date.new(2018,1,3)
      date1 = Hotel::DateRange.new(start_date, end_date)

      start_date = Date.new(2018,1,2)
      end_date = Date.new(2018,1,3)
      date2 = Hotel::DateRange.new(start_date, end_date)

      @hotel.reservation(1, date1)
      proc {@hotel.reservation(1, date2)}.must_raise Exception
    end

    it "checks reservation when start dates are the same" do
      start_date = Date.new(2018,1,1)
      end_date = Date.new(2018,1,3)
      date1 = Hotel::DateRange.new(start_date, end_date)

      start_date = Date.new(2018,1,1)
      end_date = Date.new(2018,1,3)
      date2 = Hotel::DateRange.new(start_date, end_date)

      @hotel.reservation(1, date1)
      proc {@hotel.reservation(1, date2)}.must_raise Exception
    end

    it "checks reservation when end date overlaps with start date" do
      start_date = Date.new(2018,1,5)
      end_date = Date.new(2018,1,7)
      date1 = Hotel::DateRange.new(start_date, end_date)

      start_date = Date.new(2018,1,1)
      end_date = Date.new(2018,1,6)
      date2 = Hotel::DateRange.new(start_date, end_date)

      @hotel.reservation(1, date1)
      proc {@hotel.reservation(1, date2)}.must_raise Exception
    end
    #end of 73.33% coverage --- why isn't it adding more?


    it "checks reservation when start date is the end date of existing reservation" do
      start_date = Date.new(2018,1,1)
      end_date = Date.new(2018,1,3)
      date1 = Hotel::DateRange.new(start_date, end_date)

      start_date = Date.new(2018,1,3)
      end_date = Date.new(2018,1,5)
      date2 = Hotel::DateRange.new(start_date, end_date)

      @hotel.reservation(1, date1)
      @hotel.reservation(1, date2)
      @hotel.room_reservation[1].length.must_equal 2
    end

    it "checks reservation when room is in a block" do
      start_date = Date.new(2018,1,1)
      end_date = Date.new(2018,1,3)
      date1 = Hotel::DateRange.new(start_date, end_date)

      @hotel.make_new_block(5, date1, 1)
      room = @hotel.block_rooms[0].available_rooms[0]
      proc {@hotel.reservation(room, date1)}.must_raise Exception
    end

    describe "get_all_rooms" do
      it "get_all_rooms returns an array" do
        rooms = @hotel.get_all_rooms()

        rooms.length.must_equal 20
        rooms.must_be_kind_of Array
      end
    end

    describe "get_open_rooms" do
      it "get_open_rooms for a date returns an array" do
        start_date = Date.new(2018,1,1)
        end_date = Date.new(2018,1,3)
        date1 = Hotel::DateRange.new(start_date, end_date)

        rooms = @hotel.get_open_rooms(date1)
        rooms.length.must_equal 20

        @hotel.reservation(1, date1)

        rooms = @hotel.get_open_rooms(date1)
        rooms.length.must_equal 19
      end
    end

    describe "make_new_block" do
      it "checks make_new_block" do
        @hotel.block_rooms.must_equal []


        start_date = Date.new(2018,1,1)
        end_date = Date.new(2018,1,3)
        date1 = Hotel::DateRange.new(start_date, end_date)

        @hotel.make_new_block(2, date1, 1)

        @hotel.block_rooms.length.must_equal 1
        @hotel.block_rooms[0].available_rooms.length.must_equal 2
      end
    end

    describe "check_block_for_availability" do
      it "checks check_block_for_availability" do
        @hotel.block_rooms.must_equal []


        start_date = Date.new(2018,1,1)
        end_date = Date.new(2018,1,3)
        date1 = Hotel::DateRange.new(start_date, end_date)

        @hotel.make_new_block(2, date1, 1)

        @hotel.check_block_for_availablity(1).must_equal true
        @hotel.reserve_room_from_block(1)
             # Make 16 reservations
            #  20.times do |i|
            #    @hotel.reserve_room_from_block(i + 1)
            #  end

        #@hotel.check_block_for_availablity(1).must_equal false
      end
    end

  end #end of describe reservation

  describe "Blocks" do
    describe "initialize" do
      it "checks initialize" do
  	  start_date = Date.new(2018,1,1)
  	  end_date = Date.new(2018,1,3)
  	  rooms = [1,2]
  	  date = Hotel::DateRange.new(start_date, end_date)
        block = Hotel::Block_Of_Rooms.new(rooms, date, 1)

  	  block.must_respond_to :available_rooms
  	  block.available_rooms.must_equal rooms
  	  block.available_rooms.must_be_kind_of Array

  	  block.must_respond_to :date
  	  block.date.must_equal date
  	  block.date.must_be_kind_of Hotel::DateRange

  	  block.must_respond_to :room_booked
  	  block.room_booked.must_equal [false, false]

  	  block.must_respond_to :id
  	  block.id.must_equal 1
      end
    end
  end



  #done with inst example
  #   it "only allows making a block if sufficient rooms are available" do
  #     date = Hotel::DateRange(Date.new(2018, 1, 1), Date.new(2018, 1, 5))
  #
  #     # Make 16 reservations
  #     16.times do |i|
  #       @hotel.reserve_room(i + 1, date)
  #     end
  #
  #     proc { @hotel.make_new_block(5, date, 1) }.must_raise ArgumentException
  #   end
  # end




end #end of describe ReservationSystem
