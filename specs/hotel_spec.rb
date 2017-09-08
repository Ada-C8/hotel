require_relative 'spec_helper'

describe 'Hotel' do

  before(:all) do
    @small_hotel = Hotel.new
    @name = "guest"
    @rooms = [3,2,5]

    @res1_check_out = Date.new(2017, 03, 14)
    @res1_check_in = Date.new(2017, 03, 11)

    @res2_check_in = Date.new(2017, 04, 8)
    @res2_check_out = Date.new(2017, 04, 11)
  end

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

  end

  describe "create_reservation" do
    it "creates and returns a reservation" do
      @small_hotel.create_reservation(@name, 1, @res1_check_in, @res1_check_out).must_be_instance_of Reservation
    end

    it "adds reservation to @@reservations" do
      @small_hotel.create_reservation(@name, 1, @res1_check_in, @res1_check_out)
      @small_hotel.all_reservations.last.must_be_instance_of Reservation
    end

    it "raises an exception when asked to reserve a room that is not available" do
      @small_hotel.create_reservation(@name, 1, @res1_check_in, @res1_check_out)

      # check availability for a date within the above reservation range
      check_out = Date.new(2017, 03, 18)
      check_in = Date.new(2017, 03, 13)
      proc { @small_hotel.create_reservation(1, check_in, check_out) }.must_raise ArgumentError
    end

    it "a reservation is allowed to start on the same day that a reservation for another room ends" do
      @small_hotel.create_reservation(@name, 1, @res1_check_in, @res1_check_out)

      # add another reservation for above room with check_in day same as previous reservation's check_out day
      check_out = Date.new(2017, 03, 18)
      check_in = Date.new(2017, 03, 14)
      @small_hotel.create_reservation(@name, 1, check_in, check_out)

      @small_hotel.all_reservations.length.must_equal 2
    end

  end

  describe "all_reservations" do

    it "returns an array" do
      @small_hotel.create_reservation(@name, 1, @res1_check_in, @res1_check_out)
      @small_hotel.create_reservation(@name, 1, @res2_check_in, @res2_check_out)

      @small_hotel.all_reservations.must_be_kind_of Array
    end

    it "array includes all reservations" do
      @small_hotel.create_reservation(@name, 1, @res1_check_in, @res1_check_out)
      @small_hotel.create_reservation(@name, 1, @res2_check_in, @res2_check_out)
      @small_hotel.all_reservations.length.must_equal 2
    end
  end

  describe "all_blocks" do

    it "returns an array" do
      @small_hotel.create_block(@name, @rooms, @res1_check_in, @res1_check_out)
      @small_hotel.create_block(@name, @rooms, @res2_check_in, @res2_check_out)

      @small_hotel.all_blocks.must_be_kind_of Array
    end

    it "array includes all blocks " do
      @small_hotel.create_block(@name, @rooms, @res1_check_in, @res1_check_out)
      @small_hotel.create_block(@name, @rooms, @res2_check_in, @res2_check_out)
      @small_hotel.all_blocks.length.must_equal 2
    end
  end

  describe "get_reservations_for_date" do
    it "returns an array of reservations" do
      @small_hotel.create_reservation(@name, 1, @res1_check_in, @res1_check_out)
      @small_hotel.create_reservation(@name, 1, @res2_check_in, @res2_check_out)
      date_to_check = Date.new(2017, 03, 12)
      @small_hotel.get_reservations_for_date(date_to_check).each do |reservation|
        reservation.must_be_instance_of Reservation
      end

    end

    it "returns the correct number of reservations for a certain day" do
      date_to_check = Date.new(2017, 03, 12)

      # the date_to_check falls in the below date range and should be included
      @small_hotel.create_reservation(@name, 1, @res1_check_in, @res1_check_out)

      # the date_to_check falls in the below date range (check_out day not included)
      check_out = Date.new(2017, 03, 13)
      check_in = Date.new(2017, 03, 8)
      @small_hotel.create_reservation(@name, 2, check_in, check_out)

      # the date_to_check does not fall in the below reservation's date range
      @small_hotel.create_reservation(@name, 1, @res2_check_in, @res2_check_out)

      # two reservations are included in the date_to_check
      @small_hotel.get_reservations_for_date(date_to_check).length.must_equal 2
    end
  end

  describe "availability" do
    it "returns an array of available reservations" do
      @small_hotel.create_reservation(@name, 1, @res1_check_in, @res1_check_out)

      check_out = Date.new(2017, 03, 22)
      check_in = Date.new(2017, 03, 14)
      @small_hotel.create_reservation(@name, 13, check_in, check_out)

      check_in = Date.new(2017, 03, 17)
      check_out = Date.new(2017, 04, 15)
      @small_hotel.create_block("guest", [3,2,5], check_in, check_out)
      @small_hotel.reserve_block_room("guest", 3)

      # check availability for a date within the above reservation range
      check_out = Date.new(2017, 03, 18)
      check_in = Date.new(2017, 03, 13)

      #availability should return an array of all rooms except rooms 1, 3, and 13
      #which are booked during the provided date range
      available_rooms = [2,4,5,6,7,8,9,10,11,12,14,15,16,17,18,19,20]
      @small_hotel.availability(check_in, check_out).must_equal available_rooms
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
