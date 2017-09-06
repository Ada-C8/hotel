require_relative 'spec_helper.rb'

describe "Hotel::Room" do
  describe "Room instantiation" do
    it "can initialize a room" do
      Hotel::Room.new(1).must_be_instance_of Hotel::Room
    end

    it "can't create a room that is greater or lesser than number of rooms" do
      proc{ Hotel::Room.new(0)}.must_raise ArgumentError
      proc{ Hotel::Room.new(100)}.must_raise ArgumentError
    end

    it "responds to number" do
      room = Hotel::Room.new(1)
      room.must_respond_to :number
      room.number.must_be_instance_of Integer
      room.number.must_equal 1
    end

    it "can make a hotel of rooms" do
      Hotel::Room.must_respond_to :list_all
      hotel = Hotel::Room.list_all
      hotel.must_be_instance_of Array
      20.times do |i|
        hotel[i].must_be_instance_of Hotel::Room
      end
    end

    it "can list rooms that are available" do
      start_date = Date.new(2015,9,5)
      end_date = Date.new(2015,9,8)
      all_rooms = Hotel::Room.all_available_rooms(start_date, end_date)
      all_rooms.must_be_instance_of Array
      all_rooms.length.must_equal 20
    end

    it "can list rooms that are available when there are reservations" do
      start_date = Date.new(2019,9,5)
      end_date = Date.new(2019,9,8)
      start_date2 = Date.new(2019,9,5)
      end_date2 = Date.new(2019,9,8)
      room_reservation = Hotel::Reservation.new(start_date,end_date,Hotel::Room.new(1))
      room_reservation2 = Hotel::Reservation.new(start_date,end_date,Hotel::Room.new(2))
      all_rooms = Hotel::Room.all_available_rooms(start_date, end_date)
      all_rooms.must_be_instance_of Array
      all_rooms.length.must_equal 18
    end

  end
end
