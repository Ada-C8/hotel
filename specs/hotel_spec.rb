require_relative 'spec_helper'

describe "Administration#Hotel" do

  describe "instantiate hotel" do
    it "return all rooms" do
      rooms = 12
      hotel = Administration::Hotel.new(rooms)
      hotel.all_rooms.length.must_equal 12
      hotel.all_rooms.must_be_kind_of Array
    end

    it "return a given room" do
      rooms = 12
      hotel = Administration::Hotel.new(rooms)
      hotel.all_rooms[0].must_equal 1
      hotel.all_rooms[4].must_equal 5
      hotel.all_rooms.first.must_equal 1
      hotel.all_rooms.last.must_equal 12
    end
  end

  describe "#all_reservations" do
    it "return an array of all the reservations for the hotel" do
      rooms = 12
      hotel = Administration::Hotel.new(rooms)
      hotel.all_reservations.must_be_instance_of Array
    end
  end

  describe "#listing_rooms" do
    it "return an array of all rooms" do
      rooms = 12
      room_list = Administration::Hotel.new(rooms)
      room_list.listing_rooms[0].must_equal 1
      room_list.listing_rooms[4].must_equal 5
      room_list.listing_rooms.first.must_equal 1
      room_list.listing_rooms.last.must_equal 12
    end
  end

  describe "#make_reservation" do
    it "creates a new reservation when the room is available" do
      rooms = 12
      room = 5
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      hotel = Administration::Hotel.new(rooms)
      hotel.make_reservation(check_in, check_out, room).must_equal true
    end

    it "does not create a new reservation when the room is unavailable" do
      rooms = 12
      room = 5
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      hotel = Administration::Hotel.new(rooms)
      hotel.make_reservation(check_in, check_out, room)
      hotel.make_reservation(check_in, check_out, room).must_equal false
      hotel.all_reservations.length.must_equal 1
    end

    it "ignores existing reservations for other rooms" do
      rooms = 12
      room = 1
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      hotel = Administration::Hotel.new(rooms)
      hotel.make_reservation(check_in, check_out, room)

      rooms = 12
      room = 5
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      hotel.make_reservation(check_in, check_out, room).must_equal true
      hotel.all_reservations.length.must_equal 2
    end

    it "when we look at all_reservations, then added the new reservation" do
      rooms = 12
      room = 5
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      hotel = Administration::Hotel.new(rooms)
      hotel.make_reservation(check_in, check_out, room)
      hotel.all_reservations.length.must_equal 1
      #not changed if returned false #could just add a new line in the it do blocks to test if make reservations changes the all res array
    end
  end

  describe "#find_by_date" do
    it "return an array of reservations by date" do
      hotel = Administration::Hotel.new(12)
      reservation1 = hotel.make_reservation(Date.new(2017, 8, 31), Date.new(2017, 9, 4), 5)
      reservation2 = hotel.make_reservation(Date.new(2017, 9, 4), Date.new(2017, 9, 7), 5)
      reservation3 = hotel.make_reservation(Date.new(2017, 9, 2), Date.new(2017, 9, 6), 3)
      reservation4 = hotel.make_reservation(Date.new(2017, 9, 1), Date.new(2017, 9, 4), 2)

      reservations_by_date = hotel.find_by_date(Date.new(2017, 8, 31))
      reservations_by_date.length.must_equal 1

      reservations_by_date = hotel.find_by_date(Date.new(2017, 9, 4))
      reservations_by_date.length.must_equal 2

      reservations_by_date = hotel.find_by_date(Date.new(2017, 9, 3))
      reservations_by_date.length.must_equal 3

      reservations_by_date.must_be_kind_of Array
    end
  end


end #end of hotel
