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
    @new_booking = Hotel::Booking.new("2017-09-21", "2017-09-23")
  end
  describe 'initialize' do
    it "must be an instance of Booking" do
      @new_booking.must_be_instance_of Hotel::Booking
    end
    it "must have a check in date" do
      @new_booking.must_respond_to :check_in
    end
    it "must have a check out date" do
      @new_booking.must_respond_to :check_out
    end
    it "must have a room number" do
      @new_booking.must_respond_to :room_number
    end
  end

  describe "check in date" do
    it "must be a date" do
      @new_booking.check_in.must_be_kind_of Date
    end
    it "must output the correct date" do
      @new_booking.check_in.must_equal Date.parse("2017-09-21")
    end
  end

  describe "check out date" do
    it "must be a date do" do
      @new_booking.check_out.must_be_kind_of Date
    end
    it "must output the correct date" do
      @new_booking.check_out.must_equal Date.parse("2017-09-23")
    end
  end

  describe "room number" do
    it "must be an integer" do
      @new_booking.room_number.must_be_kind_of Integer
    end
    # it "must be between 1 and 20" do
    #   @new_booking.room_number.must_equal 1, <=:, 20
    #   #@new_booking.room_number.must_equal :<=, 20
    # end
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

  describe 'all reservations' do
    it "has a collection of reservations" do
      Hotel::Reservations.all_reservations.must_be_kind_of Array
    end
  end

  describe 'new reservation' do

    it 'must create a new booking' do
      new_booking1 = Hotel::Reservations.new_reservation("2017-09-21", "2017-09-23")
      new_booking1.must_be_instance_of Hotel::Booking
    end
  end

  describe 'all reservations' do
    before do
      Hotel::Reservations.clear_reservations
      @new_booking1 = Hotel::Reservations.new_reservation("2017-09-21", "2017-09-23")
      @new_booking2 = Hotel::Reservations.new_reservation("2020-01-01", "2020-01-15")
      @new_booking3 = Hotel::Reservations.new_reservation("2019-01-01", "2019-01-15")
    end
    it 'must be an array of all reservations' do
      Hotel::Reservations.all_reservations.must_be_kind_of Array
    end
    it 'must contain correct number of reservations made' do
      Hotel::Reservations.all_reservations.length.must_equal 3
    end
    it 'must contain the first reservation made' do
      Hotel::Reservations.all_reservations[0].check_in.must_equal Date.parse("2017-09-21")
    end
    it 'must contain the correct total cost of the reservation' do
      Hotel::Reservations.all_reservations[0].total_cost.must_equal 400
    end
  end
end

describe 'DateRange' do
  before do
    @new_date_range = Hotel::DateRange.new("2019-01-01", "2019-01-04")
    # @new_date_range2 = Hotel::DateRange.new("2017-01-02", "2017-01-03")
    # @new_date_range3 = Hotel::DateRange.new("2017-02-04", "2017-02-07")
  end
  describe 'initialize' do
    it 'will initialize' do
      @new_date_range.must_be_instance_of Hotel::DateRange
    end
  end
  describe 'dates method' do
    it 'is an array' do
      @new_date_range.dates.must_be_kind_of Array
    end
    it 'must include the correct number of dates' do
      @new_date_range.dates.length.must_equal 4
    end
  end
end
