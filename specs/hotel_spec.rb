require_relative 'spec_helper'

describe "Hotel class" do

  describe "Instantiation" do

    it "Can be instantiated" do
      Hotel::Hotel.new(20, 200).must_be_instance_of Hotel::Hotel
    end

    it "Can create an array of rooms" do
      Hotel::Hotel.new(20, 200).list_of_rooms.length.must_equal 20
    end

    it "Can call the array of rooms" do
      Hotel::Hotel.new(20,200).list_of_rooms.must_equal [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18, 19, 20]
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
      @bb_hotel = Hotel::Hotel.new(20, 200)
      @bb_hotel.make_reservation('sept 8 2017', 'sept 10 2017', 4)

    end

    it "can be instantiated" do
      @bb_hotel.reservation_made.reservation_array.must_include 4
      @bb_hotel.reservation_collection.length.must_equal 1
    end

    it "Can call on class reservation methods" do
      # res = @my_hotel.make_reservation('sept 8 2017', 'sept 10 2017', 4)
      @bb_hotel.reservation_made.room_num.must_equal 4
    end

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
end #describe
