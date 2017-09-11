require_relative 'spec_helper'
require 'date_range'

describe "HotelAdmin" do
  before do
    @hotel_admin_test = BookingSystem::HotelAdmin.new
  end

  describe "initialize" do
    it "can create an instance of HotelAdmin class" do
      @hotel_admin_test.class.must_equal BookingSystem::HotelAdmin
    end

    it "can access list of all rooms in the hotel" do
      @hotel_admin_test.room_list.must_be_instance_of Array
    end

    it "can access list of all reservations in hotel" do
      @hotel_admin_test.reservation_list.must_be_instance_of Array
    end
  end

  describe "#reserve_room" do
    before do
      @first_name = "Jane"
      @last_name = "Doe"
      @room_id = 1
      @room_rate = 200.00
      @start_date = Date.new(2017, 9, 1)
      @end_date = Date.new(2017, 9, 5)

      @hotel_admin_test.reserve_room(@first_name, @last_name, @room_id, @room_rate, @start_date, @end_date)
    end

    it "ensures that reservation is added to all_reservations" do
      @hotel_admin_test.reservation_list.any? { |reservation|
        reservation.first_name == @first_name &&
        reservation.last_name == @last_name &&
        reservation.room_id == @room_id &&
        reservation.room_rate == @room_rate &&
        reservation.start_date == @start_date &&
        reservation.end_date == @end_date
      }.must_equal true
    end

    it "makes a reservation and adds it to hotel's list of reservations" do
      @hotel_admin_test.reservation_list.length.must_equal 1
    end

    it "raises an error if another reservation requests an unavailable room and date range" do
      proc {@hotel_admin_test.reserve_room(@first_name, @last_name, @room_id, @room_rate, @start_date, @end_date)}.must_raise UnavailableRoomError
    end

    it do 
    end

  end
end#of_"HotelAdmin"
























#
