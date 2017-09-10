require_relative 'spec_helper'

describe "Hotel class" do

  describe "Instantiation" do

    it "Can be instantiated" do
      Hotel::Hotel.new(20, 200).must_be_instance_of Hotel::Hotel
    end

    it "Can create an array of rooms" do
      Hotel::Hotel.new(20, 200).rooms.length.must_equal 20
    end

    it "Can call the array of rooms" do
      Hotel::Hotel.new(20,200).rooms.must_equal [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18, 19, 20]
    end

    it "Can call on price of rooms" do
      Hotel::Hotel.new(20, 200).price.must_equal 200
    end

    it "can call on collection of reservations array - will be empty" do
      Hotel::Hotel.new(20, 200).reservation_collection.must_be_instance_of Array
    end
  end #describe instantiate

  describe "#make reservation" do
    before do
      @bb_hotel = Hotel::Hotel.new(4, 200)
      @bb_hotel.make_reservation('sept 8 2017', 'sept 10 2017', 4)
    end

    it "can be instantiated" do
      @bb_hotel.reservation_made.reservation_array.must_include 4
      @bb_hotel.reservation_collection.length.must_equal 1
    end

    it "Can call on class reservation methods" do
      @bb_hotel.reservation_made.room_num.must_equal 4
    end

    it "Can return an argument error if room is not available for that date range" do
      proc { @bb_hotel.make_reservation('sept 8 2017', 'sept 9 2017', 4)}.must_raise ArgumentError
    end  ####NOTE##### Not sure how to create a test to check if there is no problem with the code
  end

  describe "#list of reservations for a specific date" do
    before do
      @bb_hotel = Hotel::Hotel.new(20, 200)
      @bb_hotel.make_reservation('sept 8 2017', 'sept 10 2017', 4)
      @bb_hotel.make_reservation('sept 7 2017', 'sept 9 2017', 3)
    end

    it "Returns an array of reservations for that date" do
      @bb_hotel.date_list_of_reservations('sept 9 2017').must_be_instance_of Array
      @bb_hotel.date_list_of_reservations('sept 9 2017').length.must_equal 2
    end
  end

  describe "#room availability" do
    before do
      @hotel = Hotel::Hotel.new(4, 200)
      @hotel.make_reservation('sept 3 2017', 'sept 5 2017', 1)
      @hotel.make_reservation('sept 5 2017', 'sept 7 2017', 1)
      @hotel.make_reservation('sept 2 2017', 'sept 4 2017', 2)
      @hotel.make_reservation('sept 6 2017', 'sept 8 2017', 2)
      @hotel.make_reservation('sept 3 2017', 'sept 5 2017', 3)
      @hotel.make_reservation('sept 2 2017', 'sept 3 2017', 3)
    end

    it "Returns an array of available rooms" do
      @hotel.room_availability('sept 1 2017', 'sept 4 2017').must_be_instance_of Array
    end

    it "Returns the room numbers available for a certain date range" do
      @hotel.room_availability('sept 1 2017', 'sept 3 2017').must_equal [1 ,4]
      @hotel.room_availability('sept 5 2017', 'sept 6 2017').must_equal [2,3,4]
      @hotel.room_availability('sept 7 2017', 'sept 8 2017').must_equal [1,3,4]
    end

    it "Returns an ArgumentError if wrong date range entered" do
      proc {@hotel.room_availability('sept 4 2017', 'sept 3 2017')}.must_raise ArgumentError
    end
  end

  describe "make block reservation method" do
    before do
      @hotel = Hotel::Hotel.new(6, 200)
      @hotel.make_reservation('sept 3 2017', 'sept 5 2017', 1)
      @hotel.make_reservation('sept 5 2017', 'sept 7 2017', 1)
      @hotel.make_reservation('sept 2 2017', 'sept 4 2017', 2)
      @hotel.make_reservation('sept 6 2017', 'sept 8 2017', 2)
      @hotel.make_reservation('sept 3 2017', 'sept 5 2017', 3)
      @hotel.make_reservation('sept 2 2017', 'sept 3 2017', 3)
    end

    it "Can create an entry in the block reservations array" do
      @hotel.make_block_reservation('sept 1 2017', 'sept 4 2017', 3).must_equal [[4,5,6]]
    end

    it "Returns an error message if not enough rooms are availanle to book" do
      proc {@hotel.make_block_reservation('sept 1 2017', 'sept 4 2017', 4)}.must_raise ArgumentError
    end

  end

  describe "making room reservation in a block" do
    before do
      @hotel = Hotel::Hotel.new(6, 200)
      @hotel.make_reservation('sept 3 2017', 'sept 5 2017', 1)
      @hotel.make_reservation('sept 5 2017', 'sept 7 2017', 1)
      @hotel.make_reservation('sept 2 2017', 'sept 4 2017', 2)
      @hotel.make_reservation('sept 6 2017', 'sept 8 2017', 2)
      @hotel.make_reservation('sept 3 2017', 'sept 5 2017', 3)
      @hotel.make_reservation('sept 2 2017', 'sept 3 2017', 3)
      @hotel.make_block_reservation('sept 1 2017', 'sept 4 2017', 3)

    end

    it "Can determine if a block has available rooms and move them to booked " do
      @hotel.reserve_room_in_block('sept 1 2017', 'sept 4 2017', 2).must_equal [6,5]
    end

  end #describe #block room reservation

end #describe
