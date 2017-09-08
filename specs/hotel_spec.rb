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

    it "makes a reservation and adds it to hotel's list of reservations" do
      first_name = "Jane"
      last_name = "Doe"

      room_id = 1
      room_rate = 200.00

      start_date = Date.parse("1/9/2017")
      end_date = Date.parse("3/9/2017")

      reservation_made = BookingSystem::Reservation.new(first_name, last_name, room_id, room_rate, start_date, end_date)

      reservation_made = BookingSystem::Reservation.new(first_name, last_name, room_id, room_rate, start_date, end_date)

      @hotel_admin_test.reservation_list << reservation_made

      @hotel_admin_test.reservation_list.must_include reservation_made
    end

    it "checks if room is available given the date range" do
      reservation2 = BookingSystem::Reservation.new("J", "E", 2, 200.00, Date.parse("1/9/2017"), end_date = Date.parse("3/9/2017"))

    end

  end
end
























#
