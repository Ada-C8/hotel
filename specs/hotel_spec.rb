require_relative 'spec_helper'

describe "hotel class" do
  describe "instantiation" do

    it "Should be able to instantiate hotel" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.must_be_instance_of HotelManagment::Hotel
    end

    it "Should have rooms array" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.rooms.must_be_instance_of Array
    end

    it "Should have reservations array" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.reservations.must_be_instance_of Array
    end

    it "Should be able to add a room" do
      new_room = HotelManagment::Room.new(1,"available")
      new_hotel = HotelManagment::Hotel.new
      new_hotel.rooms << new_room
      new_hotel.rooms.must_equal [new_room]
    end

    describe "add_20_rooms method" do
      it "Hotel should respond to add_20_rooms" do
        new_hotel = HotelManagment::Hotel.new
        new_hotel.must_respond_to :add_20_rooms
      end


      it "Rooms array should have 20 rooms inside" do
        new_hotel = HotelManagment::Hotel.new
        new_hotel.add_20_rooms
        new_hotel.rooms.length.must_equal 20
      end
    end

    it "Should be able to access list of all available rooms" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.add_20_rooms
      new_hotel.rooms[0].id.must_equal 1
      new_hotel.rooms[19].id.must_equal 20
    end
  end

  describe "create_reservation" do

    it "Should respond to .create_reservation " do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.must_respond_to :create_reservation
    end

    it "Should have reservations array" do
      new_hotel = HotelManagment::Hotel.new
      new_hotel.reservations.must_be_instance_of Array
    end

    it "should be able to add a reservation" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1, 1)
      new_hotel = HotelManagment::Hotel.new
      new_hotel.reservations << new_reservation
      new_hotel.reservations.must_equal [new_reservation]
    end

    it "Should create a reservation with a specific date range" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1, 2)

      new_reservation.check_in_date.must_equal Date.new(2017,9,5)
      new_reservation.check_out_date.must_equal Date.new(2017,9,10)

    end

    it "Should have a room number" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 1, 2)
      new_reservation.room_number.must_equal 2
    end

    it "Should have a reservation number" do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 20, 1)
      new_reservation.reservation_number.must_equal 20
    end

    it "Should respond to check_in_date " do
      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 20, 1)
      new_reservation.must_respond_to :check_in_date

    end
    it "text" do


      new_reservation = HotelManagment::Reservation.new("marisa", "morris", Date.new(2017,9,5), Date.new(2017,9,10), 20, 1)
      new_reservation.must_respond_to :check_out_date
    end
  end
end
