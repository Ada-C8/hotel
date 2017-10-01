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

      proc {
        hotel.make_reservation(check_in, check_out, room)
      }.must_raise RoomNotAvailableError

      hotel.all_reservations.length.must_equal 1
    end

    it "ignores existing reservations for other rooms" do
      rooms = 12
      hotel = Administration::Hotel.new(rooms)

      room = 1
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)
      hotel.make_reservation(check_in, check_out, room)

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
      hotel.all_reservations.length.must_equal 0
      hotel.make_reservation(check_in, check_out, room)
      hotel.all_reservations.length.must_equal 1
      #not changed if returned false #could just add a new line in the it do blocks to test if make reservations changes the all res array
    end
  end

  describe "#find_by_date" do
    it "return an array of reservations by date" do
      hotel = Administration::Hotel.new(12)
      hotel.make_reservation(Date.new(2017, 8, 31), Date.new(2017, 9, 4), 5)
      hotel.make_reservation(Date.new(2017, 9, 4), Date.new(2017, 9, 7), 5)
      hotel.make_reservation(Date.new(2017, 9, 2), Date.new(2017, 9, 6), 3)
      hotel.make_reservation(Date.new(2017, 9, 1), Date.new(2017, 9, 4), 2)

      reservations_by_date = hotel.find_by_date(Date.new(2017, 8, 31))
      reservations_by_date.length.must_equal 1

      reservations_by_date = hotel.find_by_date(Date.new(2017, 9, 4))
      reservations_by_date.length.must_equal 2

      reservations_by_date = hotel.find_by_date(Date.new(2017, 9, 3))
      reservations_by_date.length.must_equal 3

      reservations_by_date = hotel.find_by_date(Date.new(2017, 9, 7))
      reservations_by_date.length.must_equal 0

      reservations_by_date.must_be_kind_of Array
    end
  end

  describe "#find_available_rooms" do
    it "return an array of rooms available by date" do
      hotel = Administration::Hotel.new(12)
      hotel.make_reservation(Date.new(2017, 8, 31), Date.new(2017, 9, 4), 1)
      hotel.make_reservation(Date.new(2017, 9, 1), Date.new(2017, 9, 4), 2)

      rooms_by_date = hotel.find_available_rooms(Date.new(2017, 9, 3))
      rooms_by_date.length.must_equal 10

      rooms_by_date.must_be_kind_of Array
    end

    it "ignores rooms that are not reserved" do
      hotel = Administration::Hotel.new(12)
      hotel.make_reservation(Date.new(2017, 8, 31), Date.new(2017, 9, 4), 1)
      hotel.make_reservation(Date.new(2017, 9, 4), Date.new(2017, 9, 7), 2)
      hotel.make_reservation(Date.new(2017, 8, 31), Date.new(2017, 9, 4), 6)

      rooms_by_date = hotel.find_available_rooms(Date.new(2017, 9, 3))
      rooms_by_date.length.must_equal 10

      hotel = Administration::Hotel.new(12)
      hotel.make_reservation(Date.new(2018, 8, 31), Date.new(2018, 9, 4), 1)
      hotel.make_reservation(Date.new(2018, 9, 4), Date.new(2018, 9, 7), 2)
      hotel.make_reservation(Date.new(2018, 8, 31), Date.new(2018, 9, 4), 6)

      rooms_by_date = hotel.find_available_rooms(Date.new(2017, 9, 3))
      rooms_by_date.length.must_equal 12
    end
  end

  # describe "rooms_for_block" do
  #   it "create an array of rooms available for a block when no reservations exist" do
  #     hotel = Administration::Hotel.new(12)
  #
  #     rooms_by_date = hotel.rooms_for_block(Date.new(2017, 9, 3), [ 2,5,7,8,3 ])
  #     rooms_by_date.length.must_equal 4
  #   end

    # it "creates an array of rooms available for a block when a reservation for the room exists" do
    #   hotel = Administration::Hotel.new(6)
    #   hotel.make_reservation(Date.new(2017, 9, 4), Date.new(2017, 9, 7), 1)
    #   hotel.make_reservation(Date.new(2017, 9, 2), Date.new(2017, 9, 6), 2)
    #   hotel.make_reservation(Date.new(2017, 9, 1), Date.new(2017, 9, 4), 3)
    #   hotel.make_reservation(Date.new(2017, 9, 1), Date.new(2017, 9, 4), 4)
    #   hotel.make_reservation(Date.new(2017, 9, 1), Date.new(2017, 9, 4), 5)
    #
    #   rooms_by_date.block_reserved?
    #   end
  # end



end #end of hotel
