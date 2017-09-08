require_relative 'spec_helper'

describe "HotelAdmin" do
  before do
    @hotel_admin_test = BookingSystem::HotelAdmin.new
  end

  describe "initialize" do
    it "can create an instance of HotelAdmin class" do
      @hotel_admin_test.class.must_equal BookingSystem::HotelAdmin
    end

    it "can access list of all rooms in the hotel" do
      @hotel_admin_test.hotel_rooms.must_be_instance_of Array
    end

    it "can access list of all reservations in hotel" do
      @hotel_admin_test.all_reservations.must_be_instance_of Array
    end
  end

  # describe "#make_reservation" do
  #   before do
  #     first_name = "Jane"
  #     last_name = "Doe"
  #
  #     room_id = 1
  #     room_rate = 200.00
  #
  #     start_date = Date.parse("1/9/2017")
  #     end_date = Date.parse("3/9/2017")
  #
  #
  #     @reservation_test = BookingSystem::Reservation.new(first_name, last_name, room_id, room_rate, reserv_id, start_date, end_date)
  #
  #   end
  #   it "can reserve a room for a given date range" do
  #
  #   end
  #
  #   # it "makes a reservation and adds it to hotel's list of reservations" do
  #   #   @hotel_test.make_reservation(first_name, last_name, room_id, room_rate, reserv_id, start_date, end_date).must
  #   # end
  #
  # end
end
