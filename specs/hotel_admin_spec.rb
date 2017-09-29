require_relative 'spec_helper'
require 'date_range'

describe "HotelAdmin" do
  before do
    @hotel_admin_test = BookingSystem::HotelAdmin.new

    @first_name = "Jane"
    @last_name = "Doe"
    @room_id = 1
    @room_rate = 200.00
    @start_date = Date.new(2017, 9, 1)
    @end_date = Date.new(2017, 9, 5)

    @hotel_admin_test.reserve_room(@first_name, @last_name, @room_id, @room_rate, @start_date, @end_date)
  end

  describe "initialize" do
    it "can create an instance of HotelAdmin class" do
      @hotel_admin_test.class.must_equal BookingSystem::HotelAdmin
    end

    it "can access list of all rooms in the hotel" do
      @hotel_admin_test.room_list.must_be_instance_of Array
    end

    it "can access list of all (non-block) reservations in hotel" do
      @hotel_admin_test.reservation_list.must_be_instance_of Array
    end

    it "can access list of blocks in hotel" do
      @hotel_admin_test.block_list.must_be_instance_of Array
    end
  end

  describe "#find_reservations_by_date" do
    before do
      #include: @hotel_admin_test.reserve_room(@first_name, @last_name, 1, @room_rate, Date.new(2017, 9, 1), Date.new(2017, 9, 5))
      @hotel_admin_test.reserve_room(@first_name, @last_name, 1, @room_rate, Date.new(2017, 9, 5), Date.new(2017, 9, 6))
      @hotel_admin_test.reserve_room(@first_name, @last_name, 2, @room_rate, Date.new(2017, 9, 5), Date.new(2017, 9, 6))
      @hotel_admin_test.reserve_room(@first_name, @last_name, 3, @room_rate, Date.new(2017, 9, 5), Date.new(2017, 9, 6))
      @hotel_admin_test.reserve_room(@first_name, @last_name, 4, @room_rate, Date.new(2017, 9, 1), Date.new(2017, 9, 6))
    end

    it "provides list of reservations for a specific date" do
      @hotel_admin_test.find_reservations_by_date(Date.new(2017, 9, 5)).must_be_instance_of Array
      @hotel_admin_test.find_reservations_by_date(Date.new(2017, 9, 5)).length.must_equal 5
    end
  end

  describe "#rooms_available_for_date_range" do
    before do
      #include: @hotel_admin_test.reserve_room(@first_name, @last_name, 1, @room_rate, Date.new(2017, 9, 1), Date.new(2017, 9, 5))
      @hotel_admin_test.reserve_room(@first_name, @last_name, 2, @room_rate, Date.new(2017, 9, 1), Date.new(2017, 9, 5))
      @hotel_admin_test.reserve_room(@first_name, @last_name, 3, @room_rate, Date.new(2017, 9, 1), Date.new(2017, 9, 5))
      @hotel_admin_test.reserve_room(@first_name, @last_name, 4, @room_rate, Date.new(2017, 9, 1), Date.new(2017, 9, 5))
    end

    it "ensures given date range argument is a DateRange object" do
      proc { @hotel_admin_test.rooms_available_for_date_range("range") }.must_raise InvalidDateRangeError
    end

    it "provides list of rooms available for a given date range " do
      start_date = Date.new(2017, 9, 1)
      end_date = Date.new(2017, 9, 5)
      range = DateRange.new(start_date, end_date)
      @hotel_admin_test.rooms_available_for_date_range(range).must_be_instance_of Array
      @hotel_admin_test.rooms_available_for_date_range(range).length.must_equal(16)
    end
  end

  describe "#reserve_room" do
    before do
      @block_id = "Block1"
      @date_range = DateRange.new(Date.new(2017, 9, 1), Date.new(2017, 9, 5))
      @rooms_array = [
        BookingSystem::Room.new(10, 200.00),
        BookingSystem::Room.new(11, 200.00),
        BookingSystem::Room.new(12, 200.00),
        BookingSystem::Room.new(13, 200.00),
        BookingSystem::Room.new(14, 200.00)]
        @discount_room_rate = 0.20

        @block = BookingSystem::Block.new(@block_id, @date_range, @rooms_array, @discount_room_rate)
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

      it "raises an error for an invalid date range" do
        proc { @hotel_admin_test.reserve_room(@first_name, @last_name, @room_id, @room_rate, Date.new(2017, 9, 1), Date.new(2015, 9, 5)) }.must_raise InvalidDateRangeError
      end

      it "raises an error if another reservation requests an unavailable room because of dates overlapping" do
        #this should raise an error because the same reservation was booked in the before block
        proc { @hotel_admin_test.reserve_room(@first_name, @last_name, @room_id, @room_rate, @start_date, @end_date) }.must_raise UnavailableRoomError

        proc { @hotel_admin_test.reserve_room(@first_name, @last_name, @room_id, @room_rate, Date.new(2017, 9, 1), Date.new(2017, 9, 2)) }.must_raise UnavailableRoomError
      end

      it "cannot reserve a room that's in a block with same date range and room id" do
        proc { @hotel_admin_test.reserve_room(@first_name, @last_name, 10, @room_rate, Date.new(2017, 9, 1), Date.new(2017, 9, 5)) }.must_raise UnavailableRoomError
      end

      it "will allow booking for a room if requested start_date is on the end_date of a previous booking" do
        @hotel_admin_test.reserve_room(@first_name, @last_name, @room_id, @room_rate, Date.new(2017, 9, 5), Date.new(2017, 9, 6))
        @hotel_admin_test.reservation_list.length.must_equal 2
      end

    end

    describe "#reserve_block" do
      before do
        @hotel_admin_test = BookingSystem::HotelAdmin.new

        @block_id = "Block1"
        @date_range = DateRange.new(Date.new(2017, 9, 1), Date.new(2017, 9, 5))
        @rooms_array = [
          BookingSystem::Room.new(1, 200.00),
          BookingSystem::Room.new(2, 200.00),
          BookingSystem::Room.new(3, 200.00),
          BookingSystem::Room.new(4, 200.00),
          BookingSystem::Room.new(5, 200.00)]
          @discount_room_rate = 0.20

          @hotel_admin_test.reserve_block(@block_id, @date_range, @rooms_array, @discount_room_rate)
        end

      it "makes a block reservation and adds it to hotel's list of block reservations" do
        @hotel_admin_test.block_list.length.must_equal 1
      end

    end

  end#of_"HotelAdmin"
























  #
