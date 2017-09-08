require_relative 'spec_helper'

describe "BookingProgram" do
  describe "Initialize" do
    it "initializes with 20 rooms, numbered 1 through 20 and I can can access the list of all rooms " do
      new_hotel = Hotel::BookingProgram.new

      new_hotel.all_rooms.must_be_instance_of Array
      new_hotel.all_rooms.each do |room|
        room.must_be_instance_of Hotel::Room
      end


    end

  end

  describe "find_res_by_date" do
    it "Returns an array of Reservation objects" do
      new_hotel =  Hotel::BookingProgram.new

      new_hotel.make_reservation("2018-03-14", "2018-04-16", 3)

      new_hotel.make_reservation("2018-03-14", "2018-04-16", 5)

      new_hotel.make_reservation("2018-02-02", "2018-02-08", 18)

      new_hotel.make_reservation("2018-12-08", "2018-12-10", 7)

      new_hotel.make_reservation("2018-03-21", "2018-03-22", 15)


      new_hotel.find_res_by_date("2018-03-21").must_be_instance_of Array

      new_hotel.find_res_by_date("2018-03-21").count.must_equal 3

    end
  end #end find_res_by_date

  describe "make reservation" do
    it "reserves a Room and makes a Reservation object " do
      new_hotel =  Hotel::BookingProgram.new

      new_hotel.make_reservation("2018-03-14", "2018-03-16", 3)

      new_reservation = new_hotel.all_reservations[0]


      new_reservation.must_be_instance_of Hotel::Reservation
      new_reservation.id.must_equal 1

      new_res_room = new_hotel.find_room_by_id(new_reservation.room_id)
      (Date.parse("2018-03-14")...Date.parse("2018-03-16")).to_a.each do |date|
        new_res_room.all_dates.must_include date
      end

    end

    it "makes a BlockReservation object if given a block_id" do
      new_hotel =  Hotel::BookingProgram.new
      room_id = 3
      non_exist_block_id = 2
      block_id = 1

      check_in = "2018-11-10"
      check_out = "2018-11-12"

      proc {new_hotel.make_reservation(check_in, check_out, room_id, block_id)}.must_raise ArgumentError

      new_hotel.make_block(check_in,check_out,[1,3,5],10)

      new_hotel.all_blocks.count.must_equal 1

      proc {new_hotel.make_reservation(check_in,check_out,room_id,non_exist_block_id)}.must_raise ArgumentError

      # binding.pry

      new_hotel.make_reservation(check_in,check_out,room_id,block_id)





    end

  end

  describe "make block" do
    it "creates a Block and reserves a room" do
      #note, need to fix: it shouldn't reserve room officially, but should be "Blocked off" test for this when the functionality is made

      new_hotel =  Hotel::BookingProgram.new

      new_hotel.make_block("2018-03-14", "2018-03-16",[18,19,20], 2)

      new_block = new_hotel.all_blocks[0]


      new_block.must_be_instance_of Hotel::Block
      new_block.id.must_equal 1

      new_block.room_ids.each do |room_id|
        room = new_hotel.find_room_by_id(room_id)
        (Date.parse("2018-03-14")...Date.parse("2018-03-16")).to_a.each do |date|
          room.all_dates.must_include date #fix this logic later
        end
      end


    end
  end


  describe "available_rooms" do
    before do
      @new_hotel = Hotel::BookingProgram.new
      @check_in = "June 1, 2018"
      @check_out = "June 30, 2018"
      @june_rooms = @new_hotel.available_rooms(@check_in, @check_out)
    end

    it "returns an array of available rooms" do

      @june_rooms.must_be_instance_of Array
      @june_rooms.count.must_equal 20
      @june_rooms.each do |room|
        room.must_be_instance_of Hotel::Room
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



  describe "self.find_block_by_id" do
    it "can find the first and last block" do
      new_hotel = Hotel::BookingProgram.new
      # binding.pry
      # new_hotel.find_block_by_id(1).must_equal false

      new_hotel.make_block("2018-06-13", "2018-06-15", [3,4,5], 15)

      first_block = new_hotel.all_blocks[0]
      first_block.must_be_instance_of Hotel::Block
      first_block.id.must_equal 1

      found_block = new_hotel.find_block_by_id(1)

      found_block.must_equal first_block

    end

  end

  xdescribe "self.setup_rooms" do
    it "returns an array of all room objects, with the accurate number of rooms" do
      test_all_rooms = Hotel::BookingProgram.setup_rooms

      test_all_rooms.must_be_instance_of Array

      test_all_rooms.each do |room|
        room.must_be_instance_of Hotel::Room
        room.nightly_rate.must_equal 200
      end

      test_all_rooms.count.must_equal 20

    end

  end #end self.setup_rooms

  # xdescribe "find_room_by_id" do
  #   it "can find the first and last room" do
  #     new_hotel = Hotel::BookingProgram.new
  #
  #     first_room_id =1
  #     last_room_id = 20
  #
  #
  #     first_room = new_hotel.find_room_by_id(first_room_id)
  #     last_room = new_hotel.find_room_by_id(last_room_id)
  #
  #     first_room.must_be_instance_of Hotel::Room
  #     first_room.id.must_equal 1
  #
  #     last_room.must_be_instance_of Hotel::Room
  #     last_room.id.must_equal 20
  #   end
  # end
end

binding.pry
