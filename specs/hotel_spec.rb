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
    end

    it "when we look at all_reservations, then added the new reservation" do

      #not changed if returned false #could just add a new line in the it do blocks to test if make reservations changes the all res array
    end
  end


end #end of hotel
