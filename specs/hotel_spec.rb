require_relative 'spec_helper'
require 'date'

describe "Hotel" do

  before do
    @hotel = BookingSystem::Hotel.new
  end

  describe "#initialize" do
    it "should create an instance of Hotel" do
      @hotel.must_be_instance_of BookingSystem::Hotel

      @hotel.rooms.must_be_kind_of Array
      @hotel.must_respond_to :rooms

      @hotel.reservations.must_be_empty
      @hotel.must_respond_to :reservations
      # Iterate over rooms to make sure that it is 1 through 20???
    end
  end # Describe

  describe "#all_rooms_in_hotel" do
    it "should return an array of Integers (room numbers)" do
      @hotel.all_rooms_in_hotel.must_be_kind_of Array
      @hotel.all_rooms_in_hotel.each do |room_num|
        room_num.must_be_kind_of Integer
      end
    end
  end # Describe

  describe "#create_reservation" do
    # TODO: Must write a regex to check input format from the user
    xit "should pass in a check_in and check_out date in a specific format" do
      # check_in = '2001-02-03'
      # check_out = '2001-02-04'
      # @hotel.create_reservation(check_in, check_out)
      # check_in.must_be_kind_of String
      # check_out.must_be_kind_of String
    end

    it "should add only one Reservation instance to the @reservations array" do
      check_in = '2001-02-03'
      check_out = '2001-02-04'
      @hotel.create_reservation(check_in, check_out)
      @hotel.reservations.must_be_kind_of Array
      @hotel.reservations.length.must_equal 1
    end

    it "should return an instance of Reservation" do
      check_in = '2001-02-03'
      check_out = '2001-02-04'
      @hotel.create_reservation(check_in, check_out)
      @hotel.reservations[0].must_be_instance_of BookingSystem::Reservation
    end
  end # Describe

  describe "#all_reservations(date)" do
    it "should return an array of all Reservations instances with the requested date" do
      @hotel.create_reservation('2001-02-03', '2001-02-05')
      @hotel.create_reservation('2001-02-01', '2001-02-03')
      @hotel.create_reservation('2001-02-05', '2001-02-07')
      # @reservations is now filled with Reservation objects
      current_reservations = @hotel.all_reservations_on('2001-02-03')
      current_reservations.length.must_equal 1
      current_reservations.must_be_kind_of Array
    end
  end # Describe

  describe "#check_avail_rooms_for(check_in, check_out)" do
    it "should return an Array no room Integers based on the range of dates" do
      @hotel.create_reservation('2001-02-03', '2001-02-05')
      # @reservations array is full
      check_in = '2001-02-03'
      check_out = '2001-02-05'
      @hotel.check_avail_rooms_for(check_in, check_out).must_be_kind_of Array
    end

    xit "should allow no include the check_out day" do
    end
  end

end # Describe
