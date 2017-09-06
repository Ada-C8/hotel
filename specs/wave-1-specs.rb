require_relative 'spec_helper'

describe 'Room' do
  before do
    @new_room = Hotel::Room.new("1")
  end
  describe 'initialize' do
    it "must be an instance of Room" do
      @new_room.must_be_instance_of Hotel::Room
    end
  end

  describe 'room number' do

    it "must have a room number" do
      @new_room.must_respond_to :room_number
    end
    it "must output its correct room number" do
      @new_room.room_number.must_equal "1"
    end
  end

  describe 'room rate' do
    it "must have a designated room rate" do
      @new_room.must_respond_to :room_rate
    end
    it "must default to 200" do
      @new_room.room_rate.must_equal 200
    end
  end
end

describe 'Booking' do
  before do
    @new_booking = Hotel::Booking.new(9/21/17, 9/23/17)
  end
  describe 'initialize' do
    it "must be an instance of Booking" do
      @new_booking.must_be_instance_of Hotel::Booking
    end
  end
end

#TODO: Write more tests for Reservations
describe 'Reservations' do
  before do
    @new_hotel = Hotel::Reservations.new
  end
  describe 'initialize' do
    it "must be an instance of Reservations" do
      @new_hotel.must_be_instance_of Hotel::Reservations
    end
  end

  describe "collection of rooms" do
    it "has a collection of rooms" do
      Hotel::Reservations.all_rooms.must_be_kind_of Array
    end
    ##TODO: write more tests here ##
  end

  # describe 'collection of reservations' do
  #   it "has a collection of reservtations" do
  #     @new_hotel.reservations_collection.must_be_kind of Array
  #   end
  # ##TODO: write more tests
  # end
  # describe 'blocks' do
  #   it "has a colelction of blocks" do
  #     @new_hotel.blocks_collection.must_be_kind of Array
  #   end
  # end
end
