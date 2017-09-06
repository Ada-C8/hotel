require_relative 'spec_helper'

describe "Hotel" do
  before do
    @new_hotel = BookingSystem::Hotel.new(20)
    @check_in = Date.new(2017,9,15)
    @check_out = Date.new(2017,9,17)
    @date_range = BookingSystem::DateRange.new(@check_in, @check_out)
  end
  describe "#initialize" do
    it "@rooms should be kind of array" do
      @new_hotel.rooms.must_be_kind_of Array
    end
    it "Should return an array of the rigth length" do
      @new_hotel.rooms.length.must_equal 20
    end
    it "Each room should be kind of integer" do
      @new_hotel.rooms[5].must_be_kind_of Integer
    end
    it "All_reservations must be kind of array" do
      @new_hotel.all_reservations.must_be_kind_of Array
    end
  end

  #TODO more tests using make_reservation
  describe "#room_unavailable" do
    it "Returns an array of dates for given room number" do
      @new_hotel.room_unavailable(5).must_be_kind_of Array
    end
    it "Returns empty array if no reservations were made for given room number" do
      @new_hotel.room_unavailable(5).length.must_equal 0
    end
    xit "" do

    end
  end

  #TODO more tests using make_reservation
  describe "#find_room" do
    it "Returns an integer" do
      @new_hotel.find_room(@date_range).must_be_kind_of Integer
    end
    it "Should return 1 when all rooms are available" do
      @new_hotel.find_room(@date_range).must_equal 1
    end
  end

  describe "#make_reservation" do
    it "Returns an instance of class reservation" do
      @new_hotel.make_reservation(@date_range).must_be_kind_of Reservation
    end
  end




end #end of describe
