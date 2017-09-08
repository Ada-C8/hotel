require_relative 'spec_helper'

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
      @new_hotel.all_rooms.must_be_kind_of Array
    end
    ##TODO: write more tests here ##
  end

  describe 'all reservations' do
    it "has a collection of reservations" do
      @new_hotel.all_reservations.must_be_kind_of Array
    end
  end

  describe 'new reservation' do

    it 'must create a new booking' do
      new_booking1 = @new_hotel.new_reservation("2017-09-21", "2017-09-23", 1)
      new_booking1.must_be_instance_of Hotel::Booking
    end
    it 'must raise an error if the check-in date is in the past' do
      proc{new_booking = @new_hotel.new_reservation("2017-06-01", "2017-09-21")}.must_raise Hotel::InvalidDateError
    end
    it 'must raise an error if the check-in date is the same as the check-out date' do
      proc{new_booking = @new_hotel.new_reservation("2017-09-20", "2017-09-20")}.must_raise Hotel::InvalidDateError
    end
    it 'must raise an error if the check_in date is after the check-out date' do
      proc{new_booking = @new_hotel.new_reservation("2017-09-20", "2017-09-18")}.must_raise Hotel::InvalidDateError
    end
    it 'must raise an error if the date is not valid on calendar' do
      proc{new_booking = @new_hotel.new_reservation("2018-02-30", "2018-02-31")}.must_raise ArgumentError
    end
  end

  describe 'available' do
    before do
      @new_hotel.clear_reservations
      @new_reservation1 = @new_hotel.new_reservation("2018-01-01", "2018-01-05", 1)
    end
    after do
      @new_hotel.clear_reservations
    end
    it 'must must raise argument error if room is not available' do
      proc{new_reservation2 = @new_hotel.new_reservation("2018-01-01", "2018-01-04", 1)}.must_raise ArgumentError
    end
  end

  describe 'list rooms available by date' do
    before do
      @new_reservation1 = @new_hotel.new_reservation("2018-01-01", "2018-01-05", 1)
      @new_reservation2 = @new_hotel.new_reservation("2018-01-01", "2018-01-05", 2)
      @new_reservation3 = @new_hotel.new_reservation("2018-01-01", "2018-01-05", 10)
    end
    it 'must return an array' do
      @new_hotel.list_rooms_available_by_date("2018-01-02").must_be_kind_of Array
    end
    it 'must return the correct number of rooms available' do
      @new_hotel.list_rooms_available_by_date("2018-01-03").length.must_equal 17
    end
    it 'must return the correct rooms available' do

    end
  end
  # describe 'assign room number' do
  #   it 'will assign a room number if no room number is given' do
  #     new_booking = @new_hotel.new_reservation("2017-09-21", "2017-09-23")
  #     new_booking.room_number.wont_equal 0
  #   end
  # end

  # describe 'validate room number' do
  #   after do
  #     @new_hotel.clear_reservations
  #   end
  #   it 'must raise an error if a room number that does not exist is entered' do
  #     proc{new_booking = @new_hotel.new_reservation("2017-09-21", "2017-09-30", 45)}.must_raise ArgumentError
  #   end
  # end

  describe 'all reservations' do
    before do
      @new_hotel.clear_reservations
      @new_booking1 = @new_hotel.new_reservation("2017-09-21", "2017-09-23")
      @new_booking2 = @new_hotel.new_reservation("2020-01-01", "2020-01-15")
      @new_booking3 = @new_hotel.new_reservation("2019-01-01", "2019-01-15")
    end
    it 'must be an array of all reservations' do
      @new_hotel.all_reservations.must_be_kind_of Array
    end
    it 'must contain correct number of reservations made' do
      @new_hotel.all_reservations.length.must_equal 3
    end
    it 'must contain the first reservation made' do
      @new_hotel.all_reservations[0].check_in.must_equal Date.parse("2017-09-21")
    end
    it 'must contain the correct total cost of the reservation' do
      @new_hotel.all_reservations[0].total_cost.must_equal 400
    end
  end

  describe 'list_reservations_by_date' do
    before do
      @new_hotel.clear_reservations
      @new_booking1 = @new_hotel.new_reservation("2017-09-21", "2017-09-23")
      @new_booking2 = @new_hotel.new_reservation("2019-01-01", "2019-01-15")
      @new_booking3 = @new_hotel.new_reservation("2019-01-02", "2019-01-12")
      @new_booking4 = @new_hotel.new_reservation("2019-01-01", "2019-01-13")
    end
    it "must be a method of Reservations" do
      @new_hotel.must_respond_to :list_reservations_by_date
    end
    it "must be an array" do
      @new_hotel.list_reservations_by_date("2019-01-01").must_be_kind_of Array
    end
    it "must have the correct number of reservations for the date given" do
      @new_hotel.list_reservations_by_date("2019-01-04").length.must_equal 3
    end
    it "must return the correct reservations" do
      @new_hotel.list_reservations_by_date("2017-09-21")[0].room_number.must_equal @new_booking1.room_number
    end
  end
end
