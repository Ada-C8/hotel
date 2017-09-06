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

  describe "#create_reservation" do
    xit "should pass in a check_in and check_out date in a specific format" do
      check_in = '2001-02-03'
      check_out = '2001-02-04'
      @hotel.create_reservation(check_in, check_out)
      check_in.must_be_kind_of String
      check_out.must_be_kind_of String
    end

    it "should add only one Reservation instance to the @reservations array" do
      check_in = '2001-02-03'
      check_out = '2001-02-04'
      @hotel.create_reservation(check_in, check_out)
      @hotel.reservations.must_be_kind_of Array
      @hotel.reservations.length.must_equal 1
    end

    it "should be an instance of Reservation" do
      check_in = '2001-02-03'
      check_out = '2001-02-04'
      @hotel.create_reservation(check_in, check_out)
      @hotel.reservations[0].must_be_instance_of BookingSystem::Reservation
    end
  end # Describe

  describe "#all_reservations(date)" do
    it "should return an array of all Reservations instances with the requested date" do
      10.times do
        @hotel.create_reservation('2001-02-03', '2001-02-05')
      end
      # @reservations is now filled with Reservation objects
      @hotel.all_reservations_on('2001-02-04').must_be_kind_of Array
      @hotel.reservations.length.must_equal 10
      
    end
  end # Describe

  describe "#check_avail_rooms_for(date)" do
    it "should "
  end

end # Describe
