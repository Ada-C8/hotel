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
      Hotel.all_reservations.last.must_be_instance_of Reservation
      # Hotel.all_reservations.must_be_kind_of Array
    end

  end

  describe "self.all.reservations" do
    it "returns an array" do
      bb = Hotel.new
      check_out = Date.new(2017, 03, 14)
      check_in = Date.new(2017, 03, 11)
      bb.create_reservation(1, check_in, check_out)

      check_in = Date.new(2017, 04, 8)
      check_out = Date.new(2017, 04, 11)
      bb.create_reservation(1, check_in, check_out)
      Hotel.all_reservations.must_be_kind_of Array
    end

    it "@@reservations array includes all reservations" do
      bb = Hotel.new
      check_out = Date.new(2017, 03, 14)
      check_in = Date.new(2017, 03, 11)
      bb.create_reservation(1, check_in, check_out)

      check_in = Date.new(2017, 04, 8)
      check_out = Date.new(2017, 04, 11)
      bb.create_reservation(1, check_in, check_out)
      Hotel.all_reservations.length.must_equal 2
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
