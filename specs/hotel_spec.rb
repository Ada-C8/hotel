require_relative 'spec_helper'

describe 'Hotel' do

  describe "initialize" do
    it "creates a new instance of hotel" do
      Hotel.new.must_be_instance_of Hotel
    end

    it "initialize with all rooms in hotel as array" do
      Hotel.new.rooms.must_be_kind_of Array
    end

    it "room array elements range from 1 to 20" do
      small_hotel = Hotel.new
      small_hotel.rooms[0].must_equal 1
      small_hotel.rooms[19].must_equal 20
    end

    it "can access list of all rooms in hotel" do
      hotel_list = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      Hotel.new.rooms.must_equal hotel_list

    end

    # it "can access list of all reservations" do
    #   Hotel.new.rooms.must_equal hotel_list
    #
    # end
  end

  describe "create_reservation" do
    it "creates and returns a reservation" do
      bb = Hotel.new
      check_out = Date.new(2017, 03, 14)
      check_in = Date.new(2017, 03, 11)
      bb.create_reservation(1, check_in, check_out).must_be_instance_of Reservation
      # Hotel.new.must_be_instance_of Hotel
    end

    it "adds reservation to @@reservations" do
      test = Hotel.new
      check_out = Date.new(2017, 03, 14)
      check_in = Date.new(2017, 03, 11)
      test.create_reservation(1, check_in, check_out)
      test.all_reservations.last.must_be_instance_of Reservation
      # Hotel.all_reservations.must_be_kind_of Array
    end

      it "raises an exception when asked to reserve a room that is not available" do
        test_hotel= Hotel.new
        check_out = Date.new(2017, 03, 14)
        check_in = Date.new(2017, 03, 11)
        test_hotel.create_reservation(1, check_in, check_out)

        # check availability for a date within the above reservation range
        check_out = Date.new(2017, 03, 18)
        check_in = Date.new(2017, 03, 13)


        proc { test_hotel.create_reservation(1, check_in, check_out) }.must_raise ArgumentError
      end

  end

  describe "all_reservations" do
    it "returns an array" do
      bb = Hotel.new
      check_out = Date.new(2017, 03, 14)
      check_in = Date.new(2017, 03, 11)
      bb.create_reservation(1, check_in, check_out)

      check_in = Date.new(2017, 04, 8)
      check_out = Date.new(2017, 04, 11)
      bb.create_reservation(1, check_in, check_out)
      bb.all_reservations.must_be_kind_of Array
    end

    it "@@reservations array includes all reservations" do
      bb = Hotel.new
      check_out = Date.new(2017, 03, 14)
      check_in = Date.new(2017, 03, 11)
      bb.create_reservation(1, check_in, check_out)

      check_in = Date.new(2017, 04, 8)
      check_out = Date.new(2017, 04, 11)
      bb.create_reservation(1, check_in, check_out)
      bb.all_reservations.length.must_equal 2
    end
  end

  describe "get_reservations_for_date" do
    it "returns an array of reservations" do
      test_hotel = Hotel.new
      check_out = Date.new(2017, 03, 14)
      check_in = Date.new(2017, 03, 11)
      test_hotel.create_reservation(1, check_in, check_out)

      check_in = Date.new(2017, 04, 8)
      check_out = Date.new(2017, 04, 11)
      test_hotel.create_reservation(2, check_in, check_out)
      date_to_check = Date.new(2017, 03, 12)
      test_hotel.get_reservations_for_date(date_to_check).each do |reservation|
        reservation.must_be_instance_of Reservation
      end

    end

    it "returns the correct number of reservations for a certain day" do
      test_hotel = Hotel.new

      date_to_check = Date.new(2017, 03, 12)

      # the date_to_check falls in the below date range and should be included
      check_out = Date.new(2017, 03, 14)
      check_in = Date.new(2017, 03, 11)
      test_hotel.create_reservation(1, check_in, check_out)

      # the date_to_check does not fall in the below date range (check_out day not included)
      check_out = Date.new(2017, 03, 12)
      check_in = Date.new(2017, 03, 8)
      test_hotel.create_reservation(2, check_in, check_out)

      # the date_to_check falls in the below date range and should be included
      check_out = Date.new(2017, 03, 14)
      check_in = Date.new(2017, 03, 11)
      test_hotel.create_reservation(2, check_in, check_out)

      # the date_to_check does not fall in the below date range
      check_in = Date.new(2017, 04, 8)
      check_out = Date.new(2017, 04, 11)
      test_hotel.create_reservation(2, check_in, check_out)

      # two reservations are included in the date_to_check
      test_hotel.get_reservations_for_date(date_to_check).length.must_equal 2
    end
  end
  describe "availability" do
    it "returns an array of available reservations" do
      test_hotel= Hotel.new
      check_out = Date.new(2017, 03, 14)
      check_in = Date.new(2017, 03, 11)
      test_hotel.create_reservation(1, check_in, check_out)

      # check availability for a date within the above reservation range
      check_out = Date.new(2017, 03, 18)
      check_in = Date.new(2017, 03, 13)

      #availability should return an array of all rooms except room 1
      #which is booked during the preceding date_range
      available_rooms = [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      test_hotel.availability(check_in, check_out).must_equal available_rooms
    end
  end


end


# it "room array elements range from 1 to 20" do
#   small_hotel = Hotel.new
#   small_hotel.rooms[0].must_equal 1
#   small_hotel.rooms[19].must_equal 20
# end
#
# it "can access list of all rooms in hotel" do
#   hotel_list = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
#   Hotel.new.rooms.must_equal hotel_list
#
# end

# it "can access list of all reservations" do
#   Hotel.new.rooms.must_equal hotel_list
#
# end
# it "holds a name" do
#   @player.name.must_equal "Ada"
# end
