require_relative 'spec_helper'

describe "Hotel" do
  describe "Initialize" do
    it "initializes with 20 rooms, numbered 1 through 20 and I can can access the list of all rooms " do
      new_hotel = HotelBooking::Hotel.new

      new_hotel.all_rooms.must_be_instance_of Array
      new_hotel.all_rooms.each do |room|
        room.must_be_instance_of HotelBooking::Room
      end

    end

  end

  describe "find_res_by_date" do
    it "Returns an array of Reservation objects" do
      new_hotel =  HotelBooking::Hotel.new

      new_hotel.make_reservation("2018-03-14", "2018-04-16", 3)

      new_hotel.make_reservation("2018-03-14", "2018-04-16", 5)

      new_hotel.make_reservation("2018-02-02", "2018-02-08", 18)

      new_hotel.make_reservation("2018-12-08", "2018-12-10", 7)

      new_hotel.make_reservation("2018-03-21", "2018-03-22", 15)


      new_hotel.find_res_by_date("2018-03-21").must_be_instance_of Array

      new_hotel.find_res_by_date("2018-03-21").count.must_equal 3

    end
  end #end find_res_by_date

  describe "make_reservation" do
    it "reserves a Room and makes a Reservation object " do
      new_hotel =  HotelBooking::Hotel.new
      check_in ="2018-03-14"
      check_out="2018-03-16"

      new_hotel.make_reservation(check_in, check_out, 3)

      new_reservation = new_hotel.all_reservations[0]


      new_reservation.must_be_instance_of HotelBooking::Reservation
      new_reservation.id.must_equal 1

      new_res_room = new_hotel.find_room_by_id(new_reservation.room_id)
      (Date.parse(check_in)...Date.parse(check_out)).each do |date|
        new_res_room.all_dates.must_include date
      end

    end

  end

  describe "make_block_reservation" do
    it "makes a BlockReservation object if given a block id and room id" do
      new_hotel =  HotelBooking::Hotel.new
      room_id = 3
      non_exist_block_id = "B2"

      rooms_in_block = [1,3,5]

      check_in = "2018-11-10"
      check_out = "2018-11-12"

      proc {new_hotel.make_block_reservation(non_exist_block_id, room_id)}.must_raise ArgumentError

      new_hotel.make_block(check_in,check_out,rooms_in_block,10)

      new_hotel.all_blocks.count.must_equal 1

      new_block = new_hotel.all_blocks[0]
      block_id = new_block.id

      new_hotel.make_block_reservation(block_id,room_id)

      proc {new_hotel.make_block_reservation(block_id,room_id)}.must_raise ArgumentError

      new_block_reservation = new_hotel.all_reservations[-1]
      new_block_reservation.block_id.must_equal "B1"
      new_block_reservation.type.must_equal :block
    end

  end

  describe "make_block" do
    it "creates a Block and reserves a room" do
      #note, need to fix: it shouldn't reserve room officially, but should be "Blocked off" test for this when the functionality is made

      new_hotel =  HotelBooking::Hotel.new

      new_hotel.make_block("2018-03-14", "2018-03-16",[18,19,20], 2)

      new_block = new_hotel.all_blocks[0]


      new_block.must_be_instance_of HotelBooking::Block
      new_block.id.must_equal "B1"

      new_block.room_ids.each do |room_id|
        room = new_hotel.find_room_by_id(room_id)
        (Date.parse("2018-03-14")...Date.parse("2018-03-16")).each do |date|
          room.all_dates.must_include date #fix this logic later
        end
      end
    end

    it "does not allow you to create a Block if the room is reserved for any of the dates within the range you've proposed" do
      new_hotel =  HotelBooking::Hotel.new

      check_in= "2018-04-03"
      check_out = "2018-04-17"
      room_id = 5
      new_hotel.make_reservation(check_in,check_out,room_id)

      room = new_hotel.find_room_by_id(room_id)

      (Date.parse(check_in)...Date.parse(check_out)).to_a.each do |date|
        room.all_dates.must_include date
      end

      block_start= "2018-04-01"

      proc{new_hotel.make_block(block_start,check_in,[1,5],10)}.must_raise ArgumentError

      block_start2 = "2018-04-05"
      block_end = "2018-04-08"

      proc{new_hotel.make_block(block_start2,block_end,[1,5],10)}.must_raise ArgumentError

      block_end2 = "2018-05-01"
      new_hotel.make_block(check_out,block_end2,[1,5],10)

    end
  end


  describe "available_rooms" do
    before do
      @new_hotel = HotelBooking::Hotel.new
      @check_in = Date.parse("June 1, 2018")
      @check_out = Date.parse("June 30, 2018")
      @june_rooms = @new_hotel.available_rooms(@check_in, @check_out)
    end

    it "returns an array of available rooms" do

      @june_rooms.must_be_instance_of Array
      @june_rooms.count.must_equal 20
      @june_rooms.each do |room|
        room.must_be_instance_of HotelBooking::Room
      end
    end

    it "updates correctly when all rooms are reserved" do
      @new_hotel.all_rooms.each do |room|
        guest_idx = 1
        res_idx = 10
        room.reserve_room(@check_in, @check_out, res_idx, guest_idx)

        guest_idx +=1
        res_idx +=1
      end

      updated_june_rooms= @new_hotel.available_rooms(@check_in, @check_out)

      updated_june_rooms.count.must_equal 0
      updated_june_rooms.must_be_instance_of Array

    end

    it "shows the correct number when all but one room are reserved" do
      @new_hotel.all_rooms[1..-1].each do |room|
        guest_idx = 1
        res_idx = 10
        room.reserve_room(@check_in, @check_out, res_idx, guest_idx)

        guest_idx +=1
        res_idx +=1
      end

      updated_june_rooms= @new_hotel.available_rooms(@check_in, @check_out)

      updated_june_rooms.count.must_equal 1
      updated_june_rooms.must_be_instance_of Array
    end

  end #end available_rooms



  describe "find_block_by_id" do
    it "can find the first and last block" do
      new_hotel = HotelBooking::Hotel.new
      proc {new_hotel.find_block_by_id(1)}.must_raise ArgumentError

      room_ids = [3,4,5]

      new_hotel.make_block("2018-06-13", "2018-06-15", room_ids, 15)

      first_block = new_hotel.all_blocks[0]
      first_block.must_be_instance_of HotelBooking::Block
      first_block.id.must_equal "B1"

      found_block = new_hotel.find_block_by_id("B1")

      found_block.must_equal first_block

    end

  end

  describe "find_room_by_id" do
    it "can find the first and last room" do
      new_hotel = HotelBooking::Hotel.new

      first_room_id =1
      last_room_id = 20


      first_room = new_hotel.find_room_by_id(first_room_id)
      last_room = new_hotel.find_room_by_id(last_room_id)

      first_room.must_be_instance_of HotelBooking::Room
      first_room.id.must_equal 1
      first_room.must_equal new_hotel.all_rooms[0]

      last_room.must_be_instance_of HotelBooking::Room
      last_room.id.must_equal 20
      last_room.must_equal new_hotel.all_rooms[-1]
    end
  end

  describe "find_available_rooms_by_block" do
    it "Gives you an array of available rooms in a particular block and updates properly" do
      new_hotel =  HotelBooking::Hotel.new
      rooms_in_block = [1,3,5]
      room_id = 3
      non_exist_block_id = "B2"
      check_in = "2018-11-10"
      check_out = "2018-11-12"
      discounted_rate = 10

      new_hotel.make_block(check_in,check_out,rooms_in_block,discounted_rate)
      new_hotel.all_blocks.count.must_equal 1

      new_block = new_hotel.all_blocks[-1]
      block_id = new_block.id

      proc {new_hotel.find_available_rooms_by_block(non_exist_block_id)}.must_raise ArgumentError

      avail_rooms_in_block = new_hotel.find_available_rooms_by_block(block_id)

      avail_rooms_in_block.must_be_instance_of Array

      avail_rooms_in_block.each do |room|
        room.must_be_instance_of HotelBooking::Room
        room.blocks_available.must_include block_id
      end

      avail_rooms_in_block.count.must_equal 3

      new_hotel.make_block_reservation(block_id, room_id)

      updated_available_rooms_in_block = new_hotel.find_available_rooms_by_block(block_id)

      updated_available_rooms_in_block.count.must_equal 2

    end
  end

  describe "check valid dates " do
    before do
      @new_hotel = HotelBooking::Hotel.new
    end
    it "raises an error if the check-out dates is earlier than the check-in date" do
      check_in= Date.parse("March 3, 2018")
      check_out = Date.parse("February 20, 2018")

      proc { @new_hotel.check_valid_dates(check_in, check_out)}.must_raise ArgumentError
    end

    it "Raises an error when given a check-in or check-out date earlier than today" do

      check_in = Date.parse("2016-08-09")
      check_out = Date.parse("2016-08-12")

      proc { @new_hotel.check_valid_dates(check_in, check_out)}.must_raise ArgumentError
    end

    it "raises an error if given input is not a Date object" do
      check_in= 1
      check_out= 100

      proc { @new_hotel.check_valid_dates(check_in, check_out)}.must_raise ArgumentError

    end
  end
end
