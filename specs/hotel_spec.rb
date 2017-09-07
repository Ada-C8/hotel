require_relative 'spec_helper'

describe "hotel" do
  describe "ROOM_NUMBERS" do
    it "should have room numbers from 1-20" do
      Hotel::ROOM_NUMBERS.each do |num|
        (1..20).must_include num
      end
    end
    it "should have 20 hotel rooms" do
      Hotel::HOTEL_ROOMS.length.must_equal 20
    end
    it "should have 20 hotel rooms numbered 1-20" do
      Hotel::HOTEL_ROOMS.each do |room|
        (1..20).must_include room.id
      end
    end
  end

  describe "self.all_rooms" do
    it "should return an array of 20 rooms" do
      (Hotel.all_rooms).must_be_instance_of Array
      (Hotel.all_rooms).length.must_equal 20
    end
  end

  describe "self.find_room(input_id)" do
    it "should return room matching room number" do
      room_1 = Hotel.find_room(1)
      room_1.must_equal Hotel::HOTEL_ROOMS[0]
      (Hotel::HOTEL_ROOMS[0]).id.must_equal 1
      room_5 = Hotel.find_room(5)
      room_5.must_equal Hotel::HOTEL_ROOMS[4]
      (Hotel::HOTEL_ROOMS[4]).id.must_equal 5
    end
  end


  describe "self.find_reservation(input_id)" do
    it "should return reservation with mathching reservation id" do
      reservation1 = Hotel.find_reservation(1785)
      reservation1.id.must_equal 1785
    end
  end

  describe "self.find_reservation_by_block_id(input_id)" do
    it "should return an array" do
      output = Hotel.find_reservation_by_block_id(30)
      output.must_be_instance_of Array
    end
    it "should return an array of reservations" do
      output = Hotel.find_reservation_by_block_id(30)
      output.each do |element|
        element.must_be_instance_of Hotel::Reservation
      end
    end
    it "should return an array of reservations with correct block_id" do
      output = Hotel.find_reservation_by_block_id(30)
      output.each do |element|
        element.block_id.must_equal 30
      end
    end
  end
    describe "self.all_reservations" do
      it "returns an array" do
        output = Hotel.all_reservations
        output.must_be_instance_of Array
      end

      it "everthing in the array is a reservation" do
        output = Hotel.all_reservations
        output.each do |element|
          element.must_be_instance_of Hotel::Reservation
        end
      end

      it "should match what is currently in csv" do
        output = Hotel.all_reservations
        output.length.must_equal 21
        output[0].room_number.must_equal 1
        output[0].total_cost.must_equal 600
      end

    end

    describe "self.all_blocks" do
      it "returns an array" do
        output = Hotel.all_blocks
        output.must_be_instance_of Array
      end
      it "should match what is currently in the csv" do
        output = Hotel.all_blocks
        output.length.must_equal 1
      end
      it "should be filled with block objects" do
        output = Hotel.all_blocks
        output[0].must_be_instance_of Hotel::Block
      end
      it "should have a check_in date that i want " do
        output = Hotel.all_blocks
        expected_output = Date.new(2017, 9, 20)
        output[0].check_in.must_equal expected_output
      end
    end

    describe "self.cost(input_reservation)" do
      it "should return total_cost of a reservation when given id" do
        output = Hotel.cost(99)
        output.must_equal 600
      end
    end

    describe "self.access_reservation(input_date)" do
      it "should return array" do
        output = Hotel.access_reservation([2017,10,3])
        output.must_be_instance_of Array
      end
      it "everything in array should be a reservation" do
        output = Hotel.access_reservation([2017,10,3])
        output.each do |element|
          element.must_be_instance_of Hotel::Reservation
        end
      end
      it "should return an error if an invalid date is passed" do
        proc {Hotel.access_reservation([2011,10,3])}.must_raise ArgumentError
      end
    end

    describe "self.available_rooms(begin_date, end_date)" do
      it "should respond to available_rooms" do
        Hotel.must_respond_to :available_rooms
      end
      it "should return an array of available_rooms" do
        output = Hotel.available_rooms([2017,10,2], [2017,10,4])
        output.must_be_instance_of Array
      end
      it "should give a list of rooms 2- 20 as available" do
        output = Hotel.available_rooms([2017,10,2], [2017,10,4])
        (output.length).must_equal 19
      end
      it "should give 20 rooms available" do
        output = Hotel.available_rooms([2017,2,10], [2017,2,14])
        (output.length).must_equal 20
        start_on_checkout = Hotel.available_rooms([2017,10,5], [2017,10,6])
        (start_on_checkout.length).must_equal 20
      end
      it "should give 19 rooms available" do
        output = Hotel.available_rooms([2017,10,3], [2017,10,4])
        (output.length).must_equal 19
      end
      it "everything in the array should be a room" do
        output = Hotel.available_rooms([2017,10,2], [2017,10,4])
        output.each {|element| element.must_be_instance_of Hotel::Room}
      end
      it "should check blocks to see if room is available" do
        output = Hotel.truly_available([2017,9,20],[2017,9,22])
        output[0].id.must_equal 3
      end
    end
    describe "Hotel.reserve_room(begin_date, end_date)" do
      it "should respond to reserve_room" do
        Hotel.must_respond_to :reserve_room
      end
      it "should return an instance of a reservation" do
        output = Hotel.reserve_room([2017,12,22], [2017,12, 25])
        output.must_be_instance_of Hotel::Reservation
      end
      it "should raise an error if there are unavailable_rooms" do
        proc {Hotel.reserve_room([2017,11,24], [2017,11, 25])}.must_raise ArgumentError
      end
    end
    describe "Hotel.block_available(input_id)" do
      it "should return number of rooms available" do
        output = Hotel.block_available(56)
        output.must_be_instance_of Integer
      end
    end
  end
